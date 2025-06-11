object frmRelDespesas: TfrmRelDespesas
  Left = 0
  Top = 0
  Caption = 'frmRelDespesas'
  ClientHeight = 598
  ClientWidth = 806
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object RelDespesas: TRLReport
    Left = -8
    Top = 0
    Width = 794
    Height = 1123
    DataSource = dsRelatorioDespesas
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object RLBand1: TRLBand
      Left = 38
      Top = 65
      Width = 718
      Height = 24
      BandType = btTitle
      object RLLabel1: TRLLabel
        Left = 20
        Top = 6
        Width = 73
        Height = 16
        Caption = 'Vencimento'
      end
      object RLLabel2: TRLLabel
        Left = 97
        Top = 6
        Width = 59
        Height = 16
        Caption = 'Categoria'
      end
      object RLLabel3: TRLLabel
        Left = 311
        Top = 6
        Width = 55
        Height = 16
        Caption = 'Despesa'
      end
      object RLLabel4: TRLLabel
        Left = 581
        Top = 6
        Width = 67
        Height = 16
        Caption = 'R$ a pagar'
      end
      object RLLabel5: TRLLabel
        Left = 662
        Top = 6
        Width = 52
        Height = 16
        Caption = 'R$ pago'
      end
    end
    object RLBand2: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 27
      BandType = btHeader
      object rlTitulo: TRLLabel
        Left = 3
        Top = 3
        Width = 712
        Height = 18
        Alignment = taCenter
        AutoSize = False
        Caption = 'TITULO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object RLBand3: TRLBand
      Left = 38
      Top = 89
      Width = 718
      Height = 17
      BeforePrint = RLBand3BeforePrint
      object RLDBText1: TRLDBText
        Left = 20
        Top = 0
        Width = 72
        Height = 15
        Alignment = taCenter
        AutoSize = False
        DataField = 'datavencimento'
        DataSource = dsRelatorioDespesas
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDraw1: TRLDraw
        Left = 3
        Top = 0
        Width = 16
        Height = 16
        Borders.Style = bsClear
      end
      object RLDBText2: TRLDBText
        Left = 97
        Top = 0
        Width = 210
        Height = 16
        AutoSize = False
        DataField = 'categoriaDespesa'
        DataSource = dsRelatorioDespesas
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBText3: TRLDBText
        Left = 311
        Top = 0
        Width = 264
        Height = 16
        AutoSize = False
        DataField = 'descricao'
        DataSource = dsRelatorioDespesas
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBText4: TRLDBText
        Left = 580
        Top = 0
        Width = 68
        Height = 15
        Alignment = taRightJustify
        DataField = 'valorapagar'
        DataSource = dsRelatorioDespesas
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBText5: TRLDBText
        Left = 658
        Top = 4
        Width = 57
        Height = 15
        Alignment = taRightJustify
        DataField = 'valorpago'
        DataSource = dsRelatorioDespesas
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object lblPago: TRLLabel
        Left = 4
        Top = 1
        Width = 11
        Height = 16
        Caption = 'X'
      end
    end
    object RLBand4: TRLBand
      Left = 38
      Top = 106
      Width = 718
      Height = 31
      BandType = btSummary
      object RLLabel6: TRLLabel
        Left = 513
        Top = 6
        Width = 62
        Height = 18
        Alignment = taCenter
        AutoSize = False
        Caption = 'TOTAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTotalAPagar: TRLLabel
        Left = 580
        Top = 6
        Width = 72
        Height = 18
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0,00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTotalPago: TRLLabel
        Left = 658
        Top = 6
        Width = 57
        Height = 18
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0,00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object RLPDFFilter: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport Community Edition v4.0.1.2 \251 Copyright '#169' 1999-20' +
      '21 Fortes Inform'#225'tica'
    DisplayName = 'Documento PDF'
    Left = 432
    Top = 264
  end
  object dsRelatorioDespesas: TDataSource
    Left = 432
    Top = 320
  end
end
