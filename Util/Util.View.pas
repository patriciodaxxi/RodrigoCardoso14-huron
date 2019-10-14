unit Util.View;

interface

uses
  Vcl.StdCtrls, FireDAC.Comp.Client, SysUtils, Singleton.Connection, VCL.Forms,
  VCL.Controls, VCL.Mask, Windows, VCL.ComCtrls;

type
  TFormEventHelper = class helper for TForm
    procedure ValidarDataMaskEditExit(Sender: TObject);
  end;

procedure LimparCampos(const AView: TForm);
procedure HabilitarCampos(const AView: TForm; const AFlag: Boolean);
function RemoverMascara(AText: string): string;
procedure KeyUpperCase(var Key: Char);

implementation

uses
  Vcl.Grids;

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
          or (AView.Components[I] is TComboBox)
          or (AView.Components[I] is TMaskEdit)
          or (AView.Components[I] is TDateTimePicker)
        then
        begin
          (AView.Components[I] as TWinControl).Enabled := AFlag;
        end
        else if AView.Components[I] is TStringGrid then
        begin
          if AFlag then
            (AView.Components[I] as TStringGrid).Options := (AView.Components[I] as TStringGrid).Options + [goEditing] - [goRowSelect]
          else
            (AView.Components[I] as TStringGrid).Options := (AView.Components[I] as TStringGrid).Options - [goEditing] + [goRowSelect]

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
  if Key = '�' then
    Key := '�';
  if Key = '�' then
    Key := '�';
  if Key = '�' then
    Key := '�';
  if Key = '�' then
    Key := '�';
  if Key = '�' then
    Key := '�';
  if Key = '�' then
    Key := '�';
  if Key = '�' then
    Key := '�';
  if Key = '�' then
    Key := '�';
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
        Application.MessageBox('Data inv�lida', 'Aten��o', MB_OK + MB_ICONWARNING);
        (Sender as TMaskEdit).SetFocus;
      end;
    end;
  end;
end;

end.
