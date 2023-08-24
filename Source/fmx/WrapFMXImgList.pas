{$I Definition.Inc}

unit WrapFMXImgList;

interface

uses
  System.Classes, System.SysUtils, FMX.ImgList,
  PythonEngine, WrapDelphi, WrapDelphiImageList;

type
  TPyDelphiCustomImageList = class (TPyDelphiBaseImageList)
  private
    function GetDelphiObject: TCustomImageList;
    procedure SetDelphiObject(const Value: TCustomImageList);
  protected
    function BitmapItemByName_Wrapper(AArgs: PPyObject): PPyObject; cdecl;
    function BestSize_Wrapper(AArgs: PPyObject): PPyObject; cdecl;
  public
    class function DelphiObjectClass : TClass; override;
    class procedure RegisterMethods(PythonType: TPythonType); override;
    // Properties
    property DelphiObject: TCustomImageList read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiImageList = class (TPyDelphiCustomImageList)
  private
    function  GetDelphiObject: TImageList;
    procedure SetDelphiObject(const Value: TImageList);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TImageList read GetDelphiObject write SetDelphiObject;
  end;

implementation

uses
  System.Types,
  FMX.MultiResBitmap,
  WrapDelphiTypes,
  WrapFmxTypes;

{ Register the wrappers, the globals and the constants }
type
  TFmxImageListRegistration = class(TRegisteredUnit)
  public
    function Name : string; override;
    procedure RegisterWrappers(APyDelphiWrapper : TPyDelphiWrapper); override;
  end;

{ TFmxImageListRegistration }

function TFmxImageListRegistration.Name: string;
begin
  Result := 'FmxImageList';
end;

procedure TFmxImageListRegistration.RegisterWrappers(
  APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomImageList);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiImageList);
end;

{ TPyDelphiCustomImageList }

function TPyDelphiCustomImageList.BestSize_Wrapper(AArgs: PPyObject): PPyObject;

  procedure Append(const AList, AItem: PPyObject; const AIx: integer);
  begin
    with GetPythonEngine() do begin
      PyTuple_SetItem(AList, AIx, AItem);
      Py_XDecRef(AItem);
    end;
  end;

var
  LPyIndex: PPyObject;
  LPySize: PPyObject;
  LIndex: integer;
  LSize: TSize;
  LSizeF: TSizeF;
begin
  //Signatures:
  //function BestSize(const Index: Integer; var Size: TSize): Boolean; overload;
  //function BestSize(const Index: Integer; var Size: TSizeF): Boolean; overload;

  // We adjust the transmitted self argument
  Adjust(@Self);
  if GetPythonEngine().PyArg_ParseTuple(AArgs, 'iO:BestSize', @LPyIndex, @LPySize) <> 0 then begin
    if CheckIntAttribute(LPyIndex, 'Index', LIndex)
      and (CheckSizeAttribute(LPySize, 'Size', LSize)
          or
          (CheckSizeFAttribute(LPySize, 'Size', LSizeF))) then
    begin
      if not CheckIndex(LIndex, DelphiObject.Count) then
        Exit(nil);

      Result := GetPythonEngine().PyTuple_New(2);

      if CheckSizeAttribute(LPySize, 'Size', LSize) then begin
        Append(Result, GetPythonEngine().PyBool_FromLong(
          Ord(DelphiObject.BestSize(LIndex, LSize))), 0);
        Append(Result, WrapSize(PyDelphiWrapper, LSize), 1);
      end
      else
      if CheckSizeFAttribute(LPySize, 'Size', LSizeF) then begin
        Append(Result, GetPythonEngine().PyBool_FromLong(
          Ord(DelphiObject.BestSize(LIndex, LSizeF))), 0);
        Append(Result, WrapSizeF(PyDelphiWrapper, LSizeF), 1);
      end;
    end else
      Result := nil;
  end else
    Result := nil;
end;

function TPyDelphiCustomImageList.BitmapItemByName_Wrapper(
  AArgs: PPyObject): PPyObject;

  procedure Append(const AList, AItem: PPyObject; const AIx: integer);
  begin
    with GetPythonEngine() do begin
      PyTuple_SetItem(AList, AIx, AItem);
      Py_XDecRef(AItem);
    end;
  end;

var
  LPyName: PPyObject;
  LPyItem: PPyObject;
  LPySize: PPyObject;
  LName: string;
  LItem: TCustomBitmapItem;
  LSize: TSize;
begin
  //Signature:
  //function BitmapItemByName(const Name: string; var Item: TCustomBitmapItem; var Size: TSize): Boolean;

  // We adjust the transmitted self argument
  Adjust(@Self);
  if GetPythonEngine().PyArg_ParseTuple(AArgs, 'sOO:BitmapItemByName', @LPyName, @LPyItem, @LPySize) <> 0 then begin
    if CheckStrAttribute(LPyName, 'Name', LName)
      and CheckObjAttribute(LPyItem, 'Item', TCustomBitmapItem, TObject(LItem))
      and CheckSizeAttribute(LPySize, 'Size', LSize) then
    begin
      Result := GetPythonEngine().PyTuple_New(3);
      Append(Result, GetPythonEngine().PyBool_FromLong(
        Ord(DelphiObject.BitmapItemByName(LName, LItem, LSize))), 0);
      Append(Result, PyDelphiWrapper.Wrap(LItem), 1);
      Append(Result, WrapSize(PyDelphiWrapper, LSize), 2);
    end else
      Result := nil;
  end else
    Result := nil;
end;

class function TPyDelphiCustomImageList.DelphiObjectClass: TClass;
begin
  Result := TCustomImageList;
end;

function TPyDelphiCustomImageList.GetDelphiObject: TCustomImageList;
begin
  Result := TCustomImageList(inherited DelphiObject);
end;

class procedure TPyDelphiCustomImageList.RegisterMethods(
  PythonType: TPythonType);
begin
  inherited;
  PythonType.AddMethod('BitmapItemByName',
    @TPyDelphiCustomImageList.BitmapItemByName_Wrapper,
    'TCustomImageList.BitmapItemByName()'#10 +
    'Tries to find, in the source collection, the bitmap item specified by name.');
end;

procedure TPyDelphiCustomImageList.SetDelphiObject(
  const Value: TCustomImageList);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiImageList }

class function TPyDelphiImageList.DelphiObjectClass: TClass;
begin
  Result := TImageList;
end;

function TPyDelphiImageList.GetDelphiObject: TImageList;
begin
  Result := TImageList(inherited DelphiObject);
end;

procedure TPyDelphiImageList.SetDelphiObject(const Value: TImageList);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add(TFmxImageListRegistration.Create());

end.
