object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 255
  ClientWidth = 279
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Memo1: TMemo
    Left = 48
    Top = 33
    Width = 185
    Height = 177
    Lines.Strings = (
      '{'
      '  "login": 999211100073,'
      '  "password": "DD7777777"'
      '}')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 96
    Top = 216
    Width = 75
    Height = 25
    Caption = 'send'
    TabOrder = 1
    OnClick = Button1Click
  end
  object NetHTTPClient1: TNetHTTPClient
    UserAgent = 'Embarcadero URI Client/1.0'
    Left = 160
    Top = 128
  end
end
