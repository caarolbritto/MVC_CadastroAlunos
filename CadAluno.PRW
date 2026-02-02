#Include "Totvs.ch"
#Include "FwMVCDef.ch"

/*/
Tela em MVC - Cadastro de Alunos
/*/

Static cTitulo := "Cadastro de Aluno"
User Function CadAluno()
 	Local oBrowse := FwLoadBrw("CadAluno")
    Local aArea   := GetArea() // Salva a Area Atual
    Local CFunBKP := FunName() //Busca o nome da Funcao que esta em andamento
       
    Private aRotina := {} // MenuDef()

    SetFunName("CadAluno") //Setar a função do momento
     
	oBrowse := FwMBrowse():New()
	oBrowse:setAlias('SZ2')
	oBrowse:setDescription(cTitulo)
    oBrowse:SetMenuDef("CadAluno")
	oBrowse:Activate()
    
    SetFunName(CFunBKP)
    RestArea(aArea)

Return

/*/
Menu de operações da tela principal
/*/
Static Function MenuDef()

	Local aRotina := {}

	ADD OPTION aRotina Title 'Incluir'		       Action 'VIEWDEF.CadAluno' OPERATION 3 ACCESS 0
	ADD OPTION aRotina Title 'Alterar'		       Action 'VIEWDEF.CadAluno' OPERATION 4 ACCESS 0
	ADD OPTION aRotina Title 'Visualizar'	       Action 'VIEWDEF.CadAluno' OPERATION 2 ACCESS 0
	ADD OPTION aRotina Title 'Excluir'		       Action 'VIEWDEF.CadAluno' OPERATION 5 ACCESS 0
	//ADD OPTION aRotina Title 'Imprimir Rel.'	   Action 'U_RelAluno'		 OPERATION 8 ACCESS 0
	ADD OPTION aRotina Title 'Copiar'		       Action 'VIEWDEF.CadAluno' OPERATION 9 ACCESS 0

Return aRotina

/*/
Modelo de Dados
/*/
Static Function ModelDef()

	Local oModel
	Local oStruSZ2	:= FwFormStruct(1,'SZ2')

	oModel	:= MPFormModel():New("SZ2MODEL")
	oModel:SetDescription( cTitulo )

	oModel:AddFields( 'SZ2MASTER', /*cOwner*/, oStruSZ2)
    oModel:SetPrimaryKey({})

	oModel:GetModel( 'SZ2MASTER' ):SetDescription( cTitulo )

Return oModel

/*/
Interface do usuário
/*/
Static Function ViewDef()
	Local oView
	Local oModel 	:= FWLoadModel("CadAluno")
	Local oStSZ2	:= FWFormStruct(2, "SZ2")

	//Criando a view que sera o retorno da Funcao e setando o modelo da rotina
	oView := FWFormView():New()
	oView:SetModel(oModel)

	//Atribuindo formularios para interface
	oView:AddField("VIEW_SZ2", oStSZ2 ,"SZ2MASTER")

	//Setando as dimensoes de tamanho
	oView:CreateHorizontalBox("TELA",100)

	//Amarrando a View com as box
	oView:SetOwnerView("VIEW_SZ2" ,"TELA")
	
	//Habilitando e definindo o titulo
	oView:EnableTitleView('VIEW_SZ2','Cabecalho - Categoria' )
	
Return oView

Static Function BrowseDef()
    Local oBrowse := FwMBrowse():New()

   oBrowse:SetAlias("SZ2")
   oBrowse:SetDescription(cTitulo)

   // DEFINE DE ONDE SERÁ RETIRADO O MENUDEF
   oBrowse:SetMenuDef("CadAluno")
 Return(oBrowse)
