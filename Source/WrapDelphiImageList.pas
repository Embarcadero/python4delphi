{$I Definition.Inc}

unit WrapDelphiImageList;

interface

uses
  System.Classes, System.SysUtils, System.ImageList,
  PythonEngine, WrapDelphi, WrapDelphiClasses;

type
  TPyDelphiBaseImageList = class (TPyDelphiComponent)
  private
    function  GetDelphiObject: TBaseImageList;
    procedure SetDelphiObject(const Value: TBaseImageList);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TBaseImageList read GetDelphiObject write SetDelphiObject;
  end;

implementation

{ Register the wrappers, the globals and the constants }
type
  TImageListRegistration = class(TRegisteredUnit)
  public
    function Name : string; override;
    procedure RegisterWrappers(APyDelphiWrapper : TPyDelphiWrapper); override;
  end;

{ TImageListRegistration }

function TImageListRegistration.Name: string;
begin
  Result := 'ImageList';
end;

procedure TImageListRegistration.RegisterWrappers(
  APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiBaseImageList);
end;

{ TPyDelphiBaseImageList }

class function TPyDelphiBaseImageList.DelphiObjectClass: TClass;
begin
  Result := TBaseImageList;
end;

function TPyDelphiBaseImageList.GetDelphiObject: TBaseImageList;
begin
  Result := TBaseImageList(inherited DelphiObject);
end;

procedure TPyDelphiBaseImageList.SetDelphiObject(const Value: TBaseImageList);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add(TImageListRegistration.Create());

end.
