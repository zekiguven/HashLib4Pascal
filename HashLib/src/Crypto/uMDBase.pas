unit uMDBase;

interface

uses
  uHashLibTypes,
  uIHashInfo,
  uHashCryptoNotBuildIn,
  uConverters;

type
  TMDBase = class abstract(TBlockHash, ICryptoNotBuildIn)

{$WARNINGS OFF}
  strict protected
    Fm_state: THashLibUInt32Array;

  const

    C1 = UInt32($50A28BE6);
    C2 = UInt32($5A827999);
    C3 = UInt32($5C4DD124);
    C4 = UInt32($6ED9EBA1);
    C5 = UInt32($6D703EF3);
    C6 = UInt32($8F1BBCDC);
    C7 = UInt32($7A6D76E9);
    C8 = UInt32($A953FD4E);

    constructor Create(a_state_length, a_hash_size: Int32);
{$WARNINGS ON}
    function GetResult(): THashLibByteArray; override;
    procedure Finish(); override;

  public
    procedure Initialize(); override;

  end;

implementation

{ TMDBase }

constructor TMDBase.Create(a_state_length, a_hash_size: Int32);
begin
  Inherited Create(a_hash_size, 64);
  System.SetLength(Fm_state, a_state_length);

end;

procedure TMDBase.Finish;
var
  bits: UInt64;
  padindex: Int32;
  pad: THashLibByteArray;
begin
  bits := Fm_processed_bytes * 8;
  if (Fm_buffer.Pos < 56) then
    padindex := 56 - Fm_buffer.Pos
  else
    padindex := 120 - Fm_buffer.Pos;
  System.SetLength(pad, padindex + 8);

  pad[0] := $80;

  TConverters.ConvertUInt64ToBytes(bits, pad, padindex);
  padindex := padindex + 8;

  TransformBytes(pad, 0, padindex);

end;

function TMDBase.GetResult: THashLibByteArray;
begin
  result := TConverters.ConvertUInt32ToBytes(Fm_state);
end;

procedure TMDBase.Initialize;
begin
  Fm_state[0] := $67452301;
  Fm_state[1] := $EFCDAB89;
  Fm_state[2] := $98BADCFE;
  Fm_state[3] := $10325476;
  inherited Initialize;

end;

end.
