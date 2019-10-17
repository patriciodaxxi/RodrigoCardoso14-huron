unit View.TemplateList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  FireDAC.Comp.Client, System.ImageList, Vcl.ImgList, Util.View, View.Template,
  Controller, Util.Enum, Model, Singleton.Connection, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, Vcl.Menus;

type
  TTemplateListView = class(TForm)
    PanelHeader: TPanel;
    DBGrid: TDBGrid;
    StatusBar: TStatusBar;
    DataSource: TDataSource;
    PanelFilter: TPanel;
    BTNPesquisar: TButton;
    BTNIncluir: TButton;
    BTNAlterar: TButton;
    BTNExcluir: TButton;
    BTNLimpar: TButton;
    ImageList1: TImageList;
    FDQuery: TFDQuery;
    PPMList: TPopupMenu;
    MIAlterar: TMenuItem;
    MIExcluir: TMenuItem;
    MIVisualizar: TMenuItem;
    procedure DBGridTitleClick(Column: TColumn);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure BTNLimparClick(Sender: TObject);
    procedure BTNExcluirClick(Sender: TObject);
    procedure BTNIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BTNAlterarClick(Sender: TObject);
    procedure DBGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure BTNPesquisarClick(Sender: TObject);
    procedure MIAlterarClick(Sender: TObject);
    procedure MIExcluirClick(Sender: TObject);
    procedure MIVisualizarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGridDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  protected
    IDReturnSearch: Integer;
  private
    FViewTemplate: TTemplateView;
    FController: TController;
    FModoViewList: TModoViewList;
    procedure SetViewTemplate(const Value: TTemplateView);
    procedure SetController(const Value: TController);
    procedure SetModoViewList(const Value: TModoViewList);
  public
    procedure Visualizar;
    function CreateViewTemplate(AOperacao: TOperacao): TTemplateView; virtual; abstract;
    procedure CreateController; virtual; abstract;
    procedure ShowViewTemplate(AOperacao: TOperacao); virtual;
    function Search(const ACondition: string): TModel; virtual;

    property ModoViewList: TModoViewList read FModoViewList write SetModoViewList default mvlNormal;
    property ViewTemplate: TTemplateView read FViewTemplate write SetViewTemplate;
    property Controller: TController read FController write SetController;
  end;

var
  TemplateListView: TTemplateListView;

implementation

{$R *.dfm}

procedure TTemplateListView.BTNAlterarClick(Sender: TObject);
begin
  if (Assigned(DataSource.DataSet)) and (DataSource.DataSet.Active) and (not DataSource.DataSet.IsEmpty) then
  begin
    ShowViewTemplate(oUpdate);
  end;
end;

procedure TTemplateListView.BTNExcluirClick(Sender: TObject);
var
  LMensagem: string;
begin
  if (Assigned(DataSource.DataSet)) and (DataSource.DataSet.Active) and (not DataSource.DataSet.IsEmpty) then
  begin
    if Application.MessageBox('Deseja realmente excluir esse registro?', 'Atenção', MB_YESNO + MB_ICONWARNING + ICON_SMALL) = mrYes then
    begin
      CreateController;
      Controller.Model.ID := DataSource.DataSet.FieldByName('ID').AsInteger;
      try
        if Controller.Transaction(oDelete, Controller.Model, LMensagem) then
        begin
          Application.MessageBox('Registro excluído com sucesso', 'Sucesso', MB_OK + MB_ICONINFORMATION);
        end
        else
        begin
          Application.MessageBox(PWideChar('Erro: ' + LMensagem), 'Erro', MB_OK + MB_ICONERROR);
        end;
      finally
        DataSource.DataSet.Refresh;
      end;
    end;
  end;
end;

procedure TTemplateListView.BTNIncluirClick(Sender: TObject);
begin
  ShowViewTemplate(oCreate);
end;

procedure TTemplateListView.BTNLimparClick(Sender: TObject);
begin
  LimparCampos(Self);
end;

procedure TTemplateListView.BTNPesquisarClick(Sender: TObject);
begin
  CreateController;
end;

procedure TTemplateListView.DBGridDblClick(Sender: TObject);
var
  Shift: TShiftState;
  LKey: Word;
begin
  LKey := VK_Return;
  DBGrid.OnKeyDown(Sender, LKey, Shift);
end;

procedure TTemplateListView.DBGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if Odd(DataSource.DataSet.Recno) = False then
  begin
    DBGrid.Canvas.Brush.Color := ClBtnFace;
    DBGrid.Canvas.Font.Color := ClBlack;
    DBGrid.Canvas.FillRect(Rect);
    DBGrid.DefaultDrawDataCell(Rect, Column.Field, State);
  end;

  if GdSelected in State then
  begin
    DBGrid.Canvas.Brush.Color := ClHighlight;
    DbGrid.Canvas.Font.Color := ClWhite;
    DBGrid.Canvas.FillRect(Rect);
    DBGrid.DefaultDrawDataCell(Rect, Column.Field, State);
  end;
end;

procedure TTemplateListView.DBGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  with DBGrid do
  begin
    if DgRowSelect in Options then
    begin
      if Key in [VK_LEFT, VK_RIGHT] then
      begin
        case Key of
          VK_LEFT:
            if (SsCtrl in Shift) then
              Perform(WM_HSCROLL, SB_PAGELEFT, 0)
            else
              Perform(WM_HSCROLL, SB_LINELEFT, 0);

          VK_RIGHT:
            if (SsCtrl in Shift) then
              Perform(WM_HSCROLL, SB_PAGERIGHT, 0)
            else
              Perform(WM_HSCROLL, SB_LINERIGHT, 0);
        end;

        Key := 0;
        Exit;
      end;
    end;
  end;

  if Key = VK_RETURN then
  begin
    if ModoViewList = mvlNormal then
      Visualizar
    else
    begin
      IDReturnSearch := DataSource.DataSet.FieldByName('ID').AsInteger;
      Close;
    end;
  end;
end;

procedure TTemplateListView.DBGridTitleClick(Column: TColumn);
begin
  if Assigned(DataSource.DataSet) then
    TFDQuery(DataSource.DataSet).IndexFieldNames := Column.FieldName;
end;

procedure TTemplateListView.FormCreate(Sender: TObject);
begin
  BTNPesquisar.Click;
end;

procedure TTemplateListView.FormDestroy(Sender: TObject);
begin
  if Assigned(DataSource.DataSet) then
    DataSource.DataSet := nil;
  if Assigned(Controller) then
    FreeAndNil(FController);
end;

procedure TTemplateListView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F9 then
  begin
    BTNPesquisar.OnClick(nil);
  end;
end;

procedure TTemplateListView.FormShow(Sender: TObject);
begin
  if ModoViewList = mvlSearch then
  begin
    Width := 500;
    Height := 800;
    WindowState := wsNormal;
    BorderIcons := BorderIcons + [biSystemMenu] + [biMinimize] - [biMaximize];
    if DBGrid.CanFocus then
      DBGrid.SetFocus;
  end
  else
  begin
    WindowState := wsMaximized;
  end;
end;

function TTemplateListView.Search(const ACondition: string): TModel;
begin
  Result := nil;
end;

procedure TTemplateListView.SetController(const Value: TController);
begin
  FController := Value;
end;

procedure TTemplateListView.SetModoViewList(const Value: TModoViewList);
begin
  FModoViewList := Value;
end;

procedure TTemplateListView.SetViewTemplate(const Value: TTemplateView);
begin
  FViewTemplate := Value;
end;

procedure TTemplateListView.ShowViewTemplate(AOperacao: TOperacao);
begin
  FViewTemplate := CreateViewTemplate(AOperacao);
  FViewTemplate.Operacao := AOperacao;
  CreateController;
  try
    FViewTemplate.PrepareView;
    if AOperacao in [oUpdate, oRead] then
    begin
      FViewTemplate.Model := Controller.DAO.Find(DataSource.DataSet.FieldByName('ID').AsInteger);
      FViewTemplate.SetViewByModel(FViewTemplate.Model);
    end;

    HabilitarCampos(FViewTemplate, not (AOperacao = oRead));

    FViewTemplate.Operacao := AOperacao;
    FViewTemplate.ShowModal;
  finally
    if DataSource.DataSet.Active then
      DataSource.DataSet.Refresh;
    FreeAndNil(FViewTemplate);
  end;
end;

procedure TTemplateListView.Visualizar;
begin
  if (Assigned(DataSource.DataSet)) and (DataSource.DataSet.Active) and (not DataSource.DataSet.IsEmpty) then
  begin
    ShowViewTemplate(oRead);
  end;
end;

procedure TTemplateListView.MIAlterarClick(Sender: TObject);
begin
  BTNAlterar.Click;
end;

procedure TTemplateListView.MIExcluirClick(Sender: TObject);
begin
  BTNExcluir.Click;
end;

procedure TTemplateListView.MIVisualizarClick(Sender: TObject);
begin
  Visualizar;
end;

end.