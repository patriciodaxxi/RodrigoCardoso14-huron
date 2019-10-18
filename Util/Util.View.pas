unit Util.View;

interface

uses
  Vcl.StdCtrls, FireDAC.Comp.Client, SysUtils, Singleton.Connection, VCL.Forms,
  VCL.Controls, VCL.Mask, Windows, VCL.ComCtrls, Vcl.ExtCtrls, Grids;

type
  TFormEventHelper = class helper for TForm
    procedure ValidarDataMaskEditExit(Sender: TObject);
  end;

  TStringGridEventHelper = class helper for TStringGrid
    function VerifyObject(ACol, ARow: Integer): Boolean;
  end;

procedure DecimalOnly(var Key: Char; const StringGrid: TStringGrid);
procedure BloquearRedimensionamento(const AForm: TForm);
function ValidarEMail(AEMail: string): Boolean;
procedure LimparCampos(const AView: TForm);
procedure HabilitarCampos(const AView: TForm; const AFlag: Boolean);
function RemoverMascara(AText: string): string;
procedure KeyUpperCase(var Key: Char);
procedure EditFloatKeyPress(Sender: TObject; var Key: Char);

const FormatoFloat: string = '0.00000';

implementation

procedure HabilitarCampos(const AView: TForm; const AFlag: Boolean);
var
  I: Integer;
begin
  if Assigned(AView) then
  begin
    for I := 0 to Pred(AView.ComponentCount) do
    begin
      if AView.Components[I] is TWinControl then
      begin
        if (AView.Components[I] is TEdit)
          or (AView.Components[I] is TLabeledEdit)
          or (AView.Components[I] is TComboBox)
          or (AView.Components[I] is TMaskEdit)
          or (AView.Components[I] is TDateTimePicker)
        then
        begin
          (AView.Components[I] as TWinControl).Enabled := AFlag;
        end
        else if AView.Components[I] is TStringGrid then
        begin
          (AView.Components[I] as TWinControl).Enabled := True;
          if AFlag then
            (AView.Components[I] as TStringGrid).Options := (AView.Components[I] as TStringGrid).Options + [goEditing] - [goRowSelect]
          else
            (AView.Components[I] as TStringGrid).Options := (AView.Components[I] as TStringGrid).Options - [goEditing] + [goRowSelect];
        end;
      end;
    end;
  end;
end;

procedure LimparCampos(const AView: TForm);
var
  I, J: Integer;
begin
  if Assigned(AView) then
  begin
    for I := 0 to Pred(AView.ComponentCount) do
    begin
      if AView.Components[I] is TWinControl then
      begin
        (AView.Components[I] as TWinControl).Tag := 0;
        if AView.Components[I] is TEdit then
        begin
          (AView.Components[I] as TEdit).Clear;
        end
        else if AView.Components[I] is TLabeledEdit then
        begin
          (AView.Components[I] as TLabeledEdit).Clear;
        end
        else if AView.Components[I] is TComboBox then
        begin
          if (AView.Components[I] as TComboBox).Items.Count > 0 then
            (AView.Components[I] as TComboBox).ItemIndex := 0;;
        end
        else if AView.Components[I] is TMaskEdit then
        begin
          (AView.Components[I] as TMaskEdit).Clear;
        end
        else if AView.Components[I] is TDateTimePicker then
        begin
          (AView.Components[I] as TDateTimePicker).Date := Now;
        end
        else if AView.Components[I] is TStringGrid then
        begin
          for j := 0 to Pred((AView.Components[I] as TStringGrid).RowCount) do
          begin
            (AView.Components[I] as TStringGrid).Rows[j].Clear;
          end;
        end;
      end;
    end;
  end;
end;

function RemoverMascara(AText: string): string;
begin
  Result := AText;
  Result := StringReplace(Result, '/', '', [rfReplaceAll]);
  Result := StringReplace(Result, '.', '', [rfReplaceAll]);
  Result := StringReplace(Result, '-', '', [rfReplaceAll]);
end;

procedure KeyUpperCase(var Key: Char);
begin
  if CharInSet(Key, ['a'..'z']) then
    Key := UpCase(Key);
  if Key = 'ç' then
    Key := 'Ç';
  if Key = 'ã' then
    Key := 'Ã';
  if Key = 'õ' then
    Key := 'Õ';
  if Key = 'á' then
    Key := 'Á';
  if Key = 'é' then
    Key := 'É';
  if Key = 'í' then
    Key := 'Í';
  if Key = 'ó' then
    Key := 'Ó';
  if Key = 'ú' then
    Key := 'Ú';
end;

{ TFormEventHelper }

procedure TFormEventHelper.ValidarDataMaskEditExit(Sender: TObject);
var
  LDate: TDateTime;
begin
  if Assigned(Sender) then
  begin
    if not Trim(StringReplace((Sender as TMaskEdit).Text, '/', '', [rfReplaceAll])).IsEmpty then
    begin
      if not TryStrToDate((Sender as TMaskEdit).Text, LDate) then
      begin
        Application.MessageBox('Data inválida', 'Atenção', MB_OK + MB_ICONWARNING);
        (Sender as TMaskEdit).SetFocus;
      end;
    end;
  end;
end;

function ValidarEMail(AEMail: string): Boolean;
begin
  AEmail := Trim(UpperCase(AEmail));
  if Pos('@', AEmail) > 1 then
  begin
    Delete(AEmail, 1, pos('@', AEmail));
    Result := (Length(AEmail) > 0) and (Pos('.', AEmail) > 2);
  end
  else
  begin
    Result := False;
  end;
end;

procedure EditFloatKeyPress(Sender: TObject; var Key: Char);
begin
  if CharInSet(Key, ['.', ',']) then
    if Pos(FormatSettings.DecimalSeparator, TEdit(Sender).Text) > 0 then
      Key := #0
    else
      Key := FormatSettings.DecimalSeparator;

  if not (CharInSet(Key, ['0'..'9', '.', ',', #8])) then
    Key := #0;
end;

{ TStringGridEventHelper }

function TStringGridEventHelper.VerifyObject(ACol, ARow: Integer): Boolean;
begin
  Result := Assigned(Self.Objects[ACol, ARow]);
end;

procedure BloquearRedimensionamento(const AForm: TForm);
begin
  AForm.Constraints.MaxHeight := AForm.Height;
  AForm.Constraints.MinHeight := AForm.Height;
  AForm.Constraints.MaxWidth := AForm.Width;
  AForm.Constraints.MinWidth := AForm.width;
end;

procedure DecimalOnly(var Key: Char; const StringGrid: TStringGrid);
begin
  if CharInSet(Key, ['.', ',']) then
    if Pos(FormatSettings.DecimalSeparator, StringGrid.Cells[StringGrid.Col, StringGrid.Row]) > 0 then
      Key := #0
    else
      Key := FormatSettings.DecimalSeparator;
  if not CharInSet(Key, ['0'..'9', '.', ',']) then
    Key := #0;
end;

end.
