�
 TFORM1 0�	  TPF0TForm1Form1Left� Top� Width HeightwCaptionDemo of PythonFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style PixelsPerInch`
TextHeight TPanelPanel1Left Top0WidthHeight,AlignalBottom
BevelOuterbvNoneTabOrder  TButtonButton1LeftTopWidthsHeightCaptionExecute scriptTabOrder OnClickButton1Click  TButtonButton2Left� TopWidth[HeightCaptionLoad script...TabOrderOnClickButton2Click  TButtonButton3LeftTopWidthYHeightCaptionSave script...TabOrderOnClickButton3Click   TPanelPanel2Left_Top Width� Height0AlignalRightTabOrder TDBGridDBGrid1LeftTopWidth� Height.AlignalClient
DataSourceDataSource1TabOrder TitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclWindowTextTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style    TPanelPanel3Left Top Width_Height0AlignalClient
BevelOuterbvNoneTabOrder 	TSplitter	Splitter1Left Top� Width_HeightCursorcrVSplitAlignalTop  	TRichEdit	RichEdit1Left Top Width_Height� AlignalTop
ScrollBarsssBothTabOrder   TMemoMemo1Left Top� Width_Height� AlignalClientLines.Stringsimport MyDatasetZ = MyDataset.Dataset	Z.First()while not Z.EOF:&  print Z.FieldByName('NAME').AsString
  Z.Next() ,print "####################################" if Z.Locate( 'NAME', 'Boa', []):$  print "Boa found at rec#", Z.RecNo ,print "####################################"# Create our own dataset5Z = MyDataset.CreateTable( 'dbdemos', 'animals.dbf' )	Z.First()while not Z.EOF:G  print Z.FieldByName('NAME').AsString, Z.FieldByName('SIZE').AsInteger
  Z.Next()# delete our datasetdel Z 
ScrollBarsssBothTabOrder   TPythonEnginePythonEngine1DllNamepython15.dll
APIVersion�IOPythonGUIInputOutput1InitThreadsLeft   TOpenDialogOpenDialog1
DefaultExt*.pyFilter0Python files|*.py|Text files|*.txt|All files|*.*Left�   TSaveDialogSaveDialog1
DefaultExt*.pyFilter0Python files|*.py|Text files|*.txt|All files|*.*Left�   TPythonGUIInputOutputPythonGUIInputOutput1Output	RichEdit1Left@  TTableTable1Active	DatabaseNameDBDEMOS	TableNameANIMALS.DBFLeft�Top  TDataSourceDataSource1Left�Top0  TPythonModulePythonModule1EnginePythonEngine1OnInitializationPythonModule1Initialization
ModuleName	MyDatasetErrors OnAfterInitialization PythonModule1AfterInitializationLeft`   