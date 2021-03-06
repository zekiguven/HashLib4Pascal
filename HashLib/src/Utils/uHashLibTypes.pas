unit uHashLibTypes;

{$I src\Include\HashLib.inc}

interface

uses

{$IFDEF HAS_UNITSCOPE}
  System.SysUtils
{$ELSE}
    SysUtils
{$ENDIF HAS_UNITSCOPE};

type

{$IFDEF FPC}
  PUInt64 = ^UInt64;
{$ENDIF FPC}
  EInvalidOperationException = class(Exception);

{$IFDEF HAS_UNITSCOPE}
  /// <summary>
  /// Represents a dynamic array of Byte.
  /// </summary>
  THashLibByteArray = System.SysUtils.TBytes
{$ELSE}
  /// <summary>
  /// Represents a dynamic array of Byte.
  /// </summary>
    THashLibByteArray = TBytes
{$ENDIF HAS_UNITSCOPE};

  /// <summary>
  /// Represents a dynamic generic array of Type T.
  /// </summary>
  THashLibGenericArray<T> = array of T;

  /// <summary>
  /// Represents a dynamic generic array of array of Type T.
  /// </summary>
  THashLibMatrixGenericArray<T> = array of THashLibGenericArray<T>;

{$IFDEF DELPHI2010_UP}
  /// <summary>
  /// Represents a dynamic array of UInt32.
  /// </summary>
  THashLibUInt32Array = TArray<UInt32>;

  /// <summary>
  /// Represents a dynamic array of UInt64.
  /// </summary>
  THashLibUInt64Array = TArray<UInt64>;

  /// <summary>
  /// Represents a dynamic array of String.
  /// </summary>
  THashLibStringArray = TArray<String>;

  /// <summary>
  /// Represents a dynamic array of Char.
  /// </summary>
  THashLibCharArray = TArray<Char>;

  /// <summary>
  /// Represents a dynamic array of array of UInt32.
  /// </summary>
  THashLibMatrixUInt32Array = TArray<THashLibUInt32Array>;

  /// <summary>
  /// Represents a dynamic array of array of UInt64.
  /// </summary>
  THashLibMatrixUInt64Array = TArray<THashLibUInt64Array>;

{$ELSE}
  /// <summary>
  /// Represents a dynamic array of UInt32.
  /// </summary>
  THashLibUInt32Array = array of UInt32;

  /// <summary>
  /// Represents a dynamic array of UInt64.
  /// </summary>
  THashLibUInt64Array = array of UInt64;

  /// <summary>
  /// Represents a dynamic array of String.
  /// </summary>
  THashLibStringArray = array of String;

  /// <summary>
  /// Represents a dynamic array of Char.
  /// </summary>
  THashLibCharArray = array of Char;

  /// <summary>
  /// Represents a dynamic array of array of UInt32.
  /// </summary>
  THashLibMatrixUInt32Array = array of THashLibUInt32Array;

  /// <summary>
  /// Represents a dynamic array of array of UInt64.
  /// </summary>
  THashLibMatrixUInt64Array = array of THashLibUInt64Array;
{$ENDIF DELPHI2010_UP}

implementation

end.
