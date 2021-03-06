unit uDEK;

interface

uses
  uHashLibTypes,
  uIHashInfo,
  uHashResult,
  uIHashResult,
  uMultipleTransformNonBlock;

type

  TDEK = class sealed(TMultipleTransformNonBlock, IHash32, ITransformBlock)

  strict protected
    function ComputeAggregatedBytes(a_data: THashLibByteArray)
      : IHashResult; override;
  public
    constructor Create();

  end;

implementation

{ TDEK }

constructor TDEK.Create;
begin
  Inherited Create(4, 1);
end;

function TDEK.ComputeAggregatedBytes(a_data: THashLibByteArray): IHashResult;
var
  hash: UInt32;
  i: Int32;
begin
  hash := UInt32(System.Length(a_data));
  for i := 0 to System.Length(a_data) - 1 do
  begin
    hash := ((hash shl 5) xor (hash shr 27)) xor a_data[i];
  end;

  result := THashResult.Create(hash);
end;

end.
