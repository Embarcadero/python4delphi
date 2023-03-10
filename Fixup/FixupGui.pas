unit FixupGui;

interface

{$IFDEF MACOS}
uses
  Macapi.AppKit;
{$ENDIF}

{$IFDEF MACOS}
procedure _FixUp(); cdecl;
{$ELSE}
procedure FixUp(); cdecl;
{$ENDIF}

exports
{$IFDEF MACOS}
  _FixUp;
{$ELSE}
  FixUp;
{$ENDIF}

implementation

{$IFDEF MACOS}
procedure _FixUp(); cdecl; export;
begin
  //Avoid the shared library deadlock when GUI has not been initialized
  TNSScreen.Wrap(TNSScreen.OCClass.mainScreen);
end;
{$ELSE}
procedure FixUp(); cdecl; export;
begin

end;
{$ENDIF}

end.
