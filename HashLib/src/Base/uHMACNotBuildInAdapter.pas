unit uHMACNotBuildInAdapter;

{$I src\Include\HashLib.inc}

interface

uses
{$IFDEF HAS_UNITSCOPE}
  System.SysUtils,
{$ELSE}
  SysUtils,
{$ENDIF HAS_UNITSCOPE}
  uHashLibTypes,
  uHash,
  uIHash,
  uIHashInfo,
  uIHashResult,
  uNullable;

type

  THMACNotBuildInAdapter = class sealed(THash, IHMAC, IHMACNotBuildIn, IWithKey,
    ICrypto, ICryptoNotBuildIn)

  strict private

    // Fm_opad, Fm_ipad, Fm_key: THashLibByteArray;
    Fm_hash: IHash;

  strict protected

    function GetName: String; override;

    function GetKey(): THashLibByteArray; virtual;
    function GetKeyLength(): TNullableInteger;
    procedure SetKey(value: THashLibByteArray); virtual;
    procedure UpdatePads();

  public

    Fm_opad, Fm_ipad, Fm_key: THashLibByteArray;

    constructor Create(a_underlyingHash: IHash);
    procedure Initialize(); override;
    function TransformFinal(): IHashResult; override;
    procedure TransformBytes(a_data: THashLibByteArray;
      a_index, a_length: Int32); override;
    property Key: THashLibByteArray read GetKey write SetKey;
    property Name: String read GetName;
    property KeyLength: TNullableInteger read GetKeyLength;

  end;

implementation

{ THMACNotBuildInAdapter }

constructor THMACNotBuildInAdapter.Create(a_underlyingHash: IHash);
begin
  Inherited Create(a_underlyingHash.HashSize, a_underlyingHash.BlockSize);
  Fm_hash := a_underlyingHash;
  System.SetLength(Fm_key, 0);
  System.SetLength(Fm_ipad, Fm_hash.BlockSize);
  System.SetLength(Fm_opad, Fm_hash.BlockSize);
end;

function THMACNotBuildInAdapter.GetKey: THashLibByteArray;
begin
  result := System.Copy(Fm_key);
end;

function THMACNotBuildInAdapter.GetKeyLength: TNullableInteger;
begin
  result := Nil;
end;

procedure THMACNotBuildInAdapter.SetKey(value: THashLibByteArray);
begin
  if (value = Nil) then
  begin

    System.SetLength(Fm_key, 0);
  end
  else
  begin
    Fm_key := System.Copy(value);
  end;
end;

procedure THMACNotBuildInAdapter.UpdatePads;
var
  LKey: THashLibByteArray;
  Idx: Int32;
begin
  if (System.Length(Key) > Fm_hash.BlockSize) then
  begin
    LKey := Fm_hash.ComputeBytes(Key).GetBytes();
  end
  else
  begin
    LKey := Key;
  end;
  Idx := 0;
  while Idx < Fm_hash.BlockSize do
  begin
    Fm_ipad[Idx] := $36;
    Fm_opad[Idx] := $5C;
    System.Inc(Idx);
  end;

  Idx := 0;
  while Idx < System.Length(LKey) do
  begin
    Fm_ipad[Idx] := Fm_ipad[Idx] xor LKey[Idx];
    Fm_opad[Idx] := Fm_opad[Idx] xor LKey[Idx];
    System.Inc(Idx);
  end;

end;

procedure THMACNotBuildInAdapter.Initialize;
begin
  Fm_hash.Initialize();
  UpdatePads();
  Fm_hash.TransformBytes(Fm_ipad);
end;

function THMACNotBuildInAdapter.TransformFinal: IHashResult;
begin
  result := Fm_hash.TransformFinal();
  Fm_hash.TransformBytes(Fm_opad);
  Fm_hash.TransformBytes(result.GetBytes());
  result := Fm_hash.TransformFinal();
  Initialize();
end;

procedure THMACNotBuildInAdapter.TransformBytes(a_data: THashLibByteArray;
  a_index, a_length: Int32);
begin
{$IFDEF DEBUG}
  System.Assert(a_index >= 0);
  System.Assert(a_length >= 0);
  System.Assert(a_index + a_length <= System.Length(a_data));
{$ENDIF}
  Fm_hash.TransformBytes(a_data, a_index, a_length);
end;

function THMACNotBuildInAdapter.GetName: String;
begin
  result := Format('%s(%s)', [Self.ClassName, (Self.Fm_hash as THash)
    .ClassName]);

end;

end.
