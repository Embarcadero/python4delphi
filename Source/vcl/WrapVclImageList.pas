{$I Definition.Inc}

unit WrapVclImageList;

interface

uses
  System.Classes, System.SysUtils, Vcl.ImgList,
  PythonEngine, WrapDelphi, WrapDelphiImageList;

type
  TPyDelphiCustomImageList = class (TPyDelphiBaseImageList)
  private
    function  GetDelphiObject: TCustomImageList;
    procedure SetDelphiObject(const Value: TCustomImageList);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TCustomImageList read GetDelphiObject write SetDelphiObject;
  end;

implementation

{ Register the wrappers, the globals and the constants }
type
  TVclImageListRegistration = class(TRegisteredUnit)
  public
    function Name : string; override;
    procedure RegisterWrappers(APyDelphiWrapper : TPyDelphiWrapper); override;
  end;

{ TVclImageListRegistration }

function TVclImageListRegistration.Name: string;
begin
  Result := 'VclImageList';
end;

procedure TVclImageListRegistration.RegisterWrappers(
  APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomImageList);
end;

{ TPyDelphiCustomImageList }

class function TPyDelphiCustomImageList.DelphiObjectClass: TClass;
begin
  Result := TCustomImageList;
end;

function TPyDelphiCustomImageList.GetDelphiObject: TCustomImageList;
begin
  Result := TCustomImageList(inherited DelphiObject);
end;

procedure TPyDelphiCustomImageList.SetDelphiObject(const Value: TCustomImageList);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add(TVclImageListRegistration.Create());

end.
