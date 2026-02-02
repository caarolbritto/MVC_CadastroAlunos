#INCLUDE "PROTHEUS.CH"

user Function RelAluno()

Local oReport as Object
Local oSection as Object

//Classe TREPORT
oReport := TReport():New('RelAluno',"Relatório Alunos","RelAluno",{|oReport|ReportPrint(oReport,oSection)})

//Seção 1 
oSection := TRSection():New(oReport,'Alunos')

//Definição das colunas de impressão da seção 1
TRCell():New(oSection, "Z2_CODIGO" , "TRB", "Código", /*Picture*/, /*Tamanho*/, /*lPixel*/, /*{|| code-block de impressao }*/)
TRCell():New(oSection, "Z2_NOME", "TRB", "Nome" , /*Picture*/, /*Tamanho*/, /*lPixel*/, /*{|| code-block de impressao }*/)
//TRCell():New(oSection, "Z2_UF" , "TRB", "UF"    , /*Picture*/, /*Tamanho*/, /*lPixel*/, /*{|| code-block de impressao }*/)
TRCell():New(oSection, "Z2_NASCIM" , "TRB", "Nascimento"    , /*Picture*/, /*Tamanho*/, /*lPixel*/, /*{|| code-block de impressao }*/)
TRCell():New(oSection, "Z2_CPF" , "TRB", "CPF"    , /*Picture*/, /*Tamanho*/, /*lPixel*/, /*{|| code-block de impressao }*/)
TRCell():New(oSection, "Z2_RG" , "TRB", "RG"    , /*Picture*/, /*Tamanho*/, /*lPixel*/, /*{|| code-block de impressao }*/)
TRCell():New(oSection, "Z2_ENDEREC" , "TRB", "ENDEREÇO"    , /*Picture*/, /*Tamanho*/, /*lPixel*/, /*{|| code-block de impressao }*/)
TRCell():New(oSection, "Z2_MUNICIP" , "TRB", "Município"    , /*Picture*/, /*Tamanho*/, /*lPixel*/, /*{|| code-block de impressao }*/)

//Definção da collection
oColl:=TRCollection():New("TOTAL ALUNOS", "COUNT", /*oBreak*/,"Total",;
 /*cPicture*/, /*uFormula*/ oSection:Cell("Z2_CODIGO"), /*.lEndSection.*/ .F.,;
 /*.lEndReport.*/ .T., /*oParent*/ oSection, /*bCondition*/,;
 /*uContent*/ oSection:Cell("Z2_NOME") ) 

oReport:PrintGraphic()
oReport:PrintDialog()

Return

Static Function ReportPrint(oReport,oSection)

#IFDEF TOP

    Local cAlias := "TRB"

    BEGIN REPORT QUERY oSection

        BeginSql alias cAlias
            SELECT Z2_CODIGO,Z2_NOME,/*Z2_UF*/,Z2_NASCIM,Z2_CPF,Z2_RG,Z2_ENDEREC,Z2_MUNICIP
            FROM %table:SZ2% 
            WHERE D_E_L_E_T_=' '
            AND Z2_CODIGO BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR02%
            AND Z2_NOME BETWEEN %Exp:MV_PAR03% AND %Exp:MV_PAR04%
            //AND Z2_UF BETWEEN %Exp:MV_PAR03% AND %Exp:MV_PAR04%
            AND Z2_RESPON BETWEEN %Exp:MV_PAR05% AND %Exp:MV_PAR06%
            AND Z2_NASCIM BETWEEN %Exp:MV_PAR07% AND %Exp:MV_PAR08%
            ORDER BY Z2_NOME
        EndSql

    END REPORT QUERY oSection 

    oSection:aCollection[1]:SetGraphic(4,"NOME")
    oSection:PrintGraphic()
    oSection:Print()

#ENDIF

return
