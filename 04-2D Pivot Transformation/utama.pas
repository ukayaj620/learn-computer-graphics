unit utama;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ColorBox, ComCtrls;

type
  Array2D = array[1..3, 1..3] of Double;

  { TFormUtama }

  TFormUtama = class(TForm)
    ButtonAR: TButton;
    ButtonAS: TButton;
    ButtonAT: TButton;
    ButtonKomposisi: TButton;
    ButtonInit: TButton;
    ButtonTranslasi: TButton;
    ButtonScaling: TButton;
    ButtonRotasi: TButton;
    ButtonMatrix: TButton;
    ButtonClear: TButton;
    C11: TCheckBox;
    C12: TCheckBox;
    C13: TCheckBox;
    C14: TCheckBox;
    C15: TCheckBox;
    C21: TCheckBox;
    C22: TCheckBox;
    C23: TCheckBox;
    C24: TCheckBox;
    C25: TCheckBox;
    C31: TCheckBox;
    C32: TCheckBox;
    C33: TCheckBox;
    C34: TCheckBox;
    C35: TCheckBox;
    C41: TCheckBox;
    C42: TCheckBox;
    C43: TCheckBox;
    C44: TCheckBox;
    C45: TCheckBox;
    C51: TCheckBox;
    C52: TCheckBox;
    C53: TCheckBox;
    C54: TCheckBox;
    C55: TCheckBox;
    CheckBoxPivot: TCheckBox;
    ColorBox1: TColorBox;
    ComboBox1: TComboBox;
    EditTheta: TEdit;
    EditTx: TEdit;
    EditTy: TEdit;
    EditSx: TEdit;
    EditSy: TEdit;
    EditX1: TEdit;
    EditY5: TEdit;
    EditY1: TEdit;
    EditX2: TEdit;
    EditY2: TEdit;
    EditX3: TEdit;
    EditY3: TEdit;
    EditX4: TEdit;
    EditY4: TEdit;
    EditX5: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ScrollBox1: TScrollBox;
    Timer1: TTimer;
    Timer2: TTimer;
    Timer3: TTimer;
    TrackBar1: TTrackBar;
    procedure ButtonARClick(Sender: TObject);
    procedure ButtonASClick(Sender: TObject);
    procedure ButtonATClick(Sender: TObject);
    procedure ButtonInitClick(Sender: TObject);
    procedure ButtonKomposisiClick(Sender: TObject);
    procedure ButtonRotasiClick(Sender: TObject);
    procedure ButtonScalingClick(Sender: TObject);
    procedure ButtonTranslasiClick(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
    procedure ButtonMatrixClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);

  private

  public
    function matrixMultiplication(M: Array2D; N: Array2D): Array2D;
    procedure affineTranslasi(Tx: Double; Ty: Double);
    procedure affineRotasi(rad: Double);
    procedure affineScaling(Sx: Double; Sy: Double);
  end;


var
  FormUtama: TFormUtama;
  aTr : Array2D;
  aRo : Array2D;
  aSc : Array2D;
  pivotX: Double;
  pivotY: Double;
  x : array[1..5] of Double;
  y : array[1..5] of Double;


implementation

{$R *.lfm}

{ TFormUtama }

procedure TFormUtama.ButtonClearClick(Sender: TObject);

var
  px, py : integer;

begin
  Image1.Canvas.Brush.Color:= clWhite;
  Image1.Canvas.Rectangle(0, 0, Image1.Width, Image1.Height);
  Image1.Canvas.Pen.Color:= clBlack;
  Image1.Canvas.Pen.Style:= psSolid;
  Image1.Canvas.Pen.Width:= 1;
  px:= Round(Image1.Width/2);
  py:= Round(Image1.Height/2);
  Image1.Canvas.MoveTo(px,0);
  Image1.Canvas.LineTo(px,Image1.Height);
  Image1.Canvas.MoveTo(0,py);
  Image1.Canvas.LineTo(Image1.Width,py);
end;

procedure TFormUtama.ButtonTranslasiClick(Sender: TObject);
var
  Tx, Ty : Double;
  i : Integer;
begin
  ButtonClearClick(Sender);
  Tx:= StrToFloat(EditTx.Text);
  Ty:= StrToFloat(EditTy.Text);
  for i:= 1 to 5 do
  begin
    x[i]:= x[i] + Tx;
    y[i]:= y[i] + Ty;
  end;
  pivotX:= pivotX + Tx;
  pivotY:= pivotY + Ty;
  ButtonMatrixClick(Sender);
end;

procedure TFormUtama.ButtonInitClick(Sender: TObject);
var
  i : Integer;
  ObjEditX, ObjEditY : TEdit;
begin
  for i:= 1 to 5 do
  begin
    ObjEditX:= TEdit(FormUtama.FindComponent('EditX' + IntToStr(i)));
    ObjEditY:= TEdit(FormUtama.FindComponent('EditY' + IntToStr(i)));
    x[i]:= StrToFloat(ObjEditX.Text);
    y[i]:= StrToFloat(ObjEditY.Text);
  end;
  pivotX:= 113;
  pivotY:= 100;
end;

procedure TFormUtama.ButtonATClick(Sender: TObject);
begin
  EditTx.Text:= FloatToStr(-1);
  EditTy.Text:= FloatToStr(-1);
  Timer1.Enabled:= not Timer1.Enabled;
end;

procedure TFormUtama.ButtonARClick(Sender: TObject);
begin
  EditTheta.Text:= FloatToStr(1);
  Timer2.Enabled:= not Timer2.Enabled;
end;

procedure TFormUtama.ButtonASClick(Sender: TObject);
begin
  EditSx.Text:= FloatToStr(1.01);
  EditSy.Text:= FloatToStr(1.01);
  Timer3.Enabled:= not Timer3.Enabled;
end;

procedure TFormUtama.ButtonKomposisiClick(Sender: TObject);
var
  t, rad, temp, Sx, Sy : Double;
  res_1, res_2: Array2D;
  i : Integer;
begin
  ButtonClearClick(Sender);
  t:= StrToFloat(EditTheta.Text);
  Sx:= StrToFloat(EditSx.Text);
  Sy:= StrToFloat(EditSy.Text);
  rad:= t * Pi/180;
  affineRotasi(rad);
  res_1:= aRo;
  //EditResult.text:= FloatToStr(pivotX) + ' ' + FloatToStr(pivotY);
  for i:= 1 to 5 do
  begin
    temp:= x[i];
    x[i]:= res_1[1,1]*x[i] + res_1[1,2]*y[i] + res_1[1,3]*1;
    y[i]:= res_1[2,1]*temp + res_1[2,2]*y[i] + res_1[2,3]*1;
  end;
  temp:= pivotX;
  pivotX:= res_1[1,1]*pivotX + res_1[1,2]*pivotY + res_1[1,3]*1;
  pivotY:= res_1[2,1]*temp + res_1[2,2]*pivotY + res_1[2,3]*1;
  affineTranslasi(pivotX, pivotY);
  affineScaling(Sx, Sy);
  res_1:= matrixMultiplication(aTr, aSc);
  affineTranslasi(-1 * pivotX, -1 * pivotY);
  res_2:= matrixMultiplication(res_1, aTr);
  for i:= 1 to 5 do
  begin
    x[i]:= res_2[1,1]*x[i] + res_2[1,2]*y[i] + res_2[1,3]*1;
    y[i]:= res_2[2,1]*x[i] + res_2[2,2]*y[i] + res_2[2,3]*1;
  end;
  ButtonMatrixClick(Sender);

end;

procedure TFormUtama.ButtonRotasiClick(Sender: TObject);
var
  t, rad, temp : Double;
  i : Integer;
  res_1, res_2 : Array2D;
begin
  ButtonClearClick(Sender);
  t:= StrToFloat(EditTheta.Text);
  rad:= t * Pi/180;
  if CheckBoxPivot.Checked = false then
  begin
    for i:= 1 to 5 do
    begin
      temp:= x[i];
      x[i]:= x[i]*Cos(rad)-y[i]*Sin(rad);
      y[i]:= temp*Sin(rad)+y[i]*Cos(rad);
    end;
    temp:= pivotX;
    pivotX:= pivotX*Cos(rad)-pivotY*Sin(rad);
    pivotY:= temp*Sin(rad)+pivotY*Cos(rad);
  end
  else
  begin
    affineTranslasi(pivotX, pivotY);
    affineRotasi(rad);
    res_1:= matrixMultiplication(aTr, aRo);
    affineTranslasi(-1 * pivotX, -1 * pivotY);
    res_2:= matrixMultiplication(res_1, aTr);
    for i:= 1 to 5 do
    begin
      temp:= x[i];
      x[i]:= res_2[1,1]*x[i] + res_2[1,2]*y[i] + res_2[1,3]*1;
      y[i]:= res_2[2,1]*temp + res_2[2,2]*y[i] + res_2[2,3]*1;
    end;
  end;
  ButtonMatrixClick(Sender);
end;

procedure TFormUtama.ButtonScalingClick(Sender: TObject);
var
  Sx, Sy : Double;
  i : Integer;
  res_1 : Array2D;
  res_2 : Array2D;
begin
  ButtonClearClick(Sender);
  Sx:= StrToFloat(EditSx.Text);
  Sy:= StrToFloat(EditSy.Text);
  if CheckBoxPivot.Checked = false then
  begin
     for i:= 1 to 5 do
     begin
       x[i]:= x[i] * Sx;
       y[i]:= y[i] * Sy;
     end;
     ButtonMatrixClick(Sender);
     pivotX:= pivotX * Sx;
     pivotY:= pivotY * Sy;
  end
  else
  begin
     affineTranslasi(pivotX, pivotY);
     affineScaling(Sx, Sy);
     res_1:= matrixMultiplication(aTr, aSc);
     affineTranslasi(-1 * pivotX, -1 * pivotY);
     res_2:= matrixMultiplication(res_1, aTr);
     for i:= 1 to 5 do
     begin
        x[i]:= res_2[1,1]*x[i] + res_2[1,2]*y[i] + res_2[1,3]*1;
        y[i]:= res_2[2,1]*x[i] + res_2[2,2]*y[i] + res_2[2,3]*1;
     end;
     ButtonMatrixClick(Sender);
     //EditResult.text:= FloatToStr(x[1]) + ' ' + FloatToStr(y[1]) + ' ' + FloatToStr(pivotX) + ' ' + FloatToStr(pivotY);
  end;
end;

procedure TFormUtama.ButtonMatrixClick(Sender: TObject);

var
  i, j : integer;
  px, py : integer;
  ObjCheckBox : TCheckBox;
begin

  px:= Round(Image1.Width/2);
  py:= Round(Image1.Height/2);

  for i:= 1 to 5 do
  begin
    Image1.Canvas.TextOut(px+round(x[i]),py-round(y[i]), 'P'+IntToStr(i));
  end;

  Image1.Canvas.Pen.Color:= ColorBox1.Selected;
  Image1.Canvas.Pen.Style:= psSolid;
  Image1.Canvas.Pen.Width:= TrackBar1.Position;

  for i:= 1 to 5 do
  begin
    for j:= 1 to 5 do
    begin
      ObjCheckBox:= TCheckBox(FormUtama.FindComponent('C' + IntToStr(i) + IntToStr(j)));
      if ObjCheckBox.Checked = True then
      begin
        Image1.Canvas.MoveTo(px+round(x[i]),py-round(y[i]));
        Image1.Canvas.LineTo(px+round(x[j]),py-round(y[j]));
      end;
    end;
  end;

  //Image1.Canvas.MoveTo(px+x[5],py-y[5]);
  //for i:= 1 to 5 do
  //begin
  //  Image1.Canvas.LineTo(px+x[i],py-y[i]);
  //end;
end;

procedure TFormUtama.FormCreate(Sender: TObject);
var
  i,j : integer;
begin
  Combobox1.Items.Add('Star/Pentagonal');
  Combobox1.Items.Add('Limas');
  for i:= 1 to 3 do
  begin
    for j:= 1 to 3 do
    begin
      aTr[i,j]:= 0;
      aSc[i,j]:= 0;
      aRo[i,j]:= 0;
    end;
  end;
  aTr[3,3]:= 1;
  aSc[3,3]:= 1;
  aRo[3,3]:= 1;
end;

procedure TFormUtama.FormShow(Sender: TObject);
begin
  ButtonClearClick(Sender);
end;

procedure TFormUtama.Timer1Timer(Sender: TObject);
var
  i, px, py: Integer;
  tempX, tempY: Double;
begin
  px:= Round(Image1.Width/2);
  py:= Round(Image1.Height/2);
  tempX:= StrToFloat(EditTx.Text);
  tempY:= StrToFloat(EditTy.Text);
  for i:= 1 to 5 do
  begin
  if (px + round(x[i]) + round(tempX) < 0) OR (px + round(x[i]) + round(tempX) > Image1.Width) then
      EditTx.Text:= FloatToStr((-1) * tempX);
  if (py - round(y[i]) - round(tempY) < 0) OR (py - round(y[i]) - round(tempY) > Image1.Height) then
      EditTy.Text:= FloatToStr((-1) * tempY);
  end;
  ButtonTranslasiClick(Sender);
end;

procedure TFormUtama.Timer2Timer(Sender: TObject);
var
  i: integer;
  px, py, tempTheta: Double;
begin
  px:= Round(Image1.Width/2);
  py:= Round(Image1.Height/2);
  tempTheta:= StrToFloat(EditTheta.Text);
  for i:= 1 to 5 do
  begin
    if (px + round(x[i])  > Image1.Width)
       OR (py - round(y[i]) < 0)
       OR (py - round(y[i]) > Image1.Height)
       OR (px + round(x[i]) < 0) then
    begin
      EditTheta.Text:= FloatToStr(-1 * tempTheta);
    end;
  end;
  ButtonRotasiClick(Sender);
end;

procedure TFormUtama.Timer3Timer(Sender: TObject);
var
  i, px, py: Integer;
  tempX, tempY: Double;
begin
  px:= Round(Image1.Width/2);
  py:= Round(Image1.Height/2);
  tempX:= StrToFloat(EditSx.Text);
  tempY:= StrToFloat(EditSy.Text);
  for i:= 1 to 5 do
  begin
    if (px + round(x[i] * tempX)  > Image1.Width) OR (py - round(y[i] * tempY) < 0) then
    begin
      EditSx.Text:= FloatToStr(0.99);
      EditSy.Text:= FloatToStr(0.99);
    end;
  end;
  ButtonScalingClick(Sender);
end;

function TFormUtama.matrixMultiplication(M: Array2D; N: Array2D): Array2D;
var
  res : Array2D;
  i,j,k : integer;
begin
  for i:= 1 to 3 do
  begin
    for j:= 1 to 3 do
    begin
      res[i,j]:= 0;
      for k:= 1 to 3 do
      begin
        res[i,j]:= res[i,j] + (M[i,k]*N[k,j]);
      end;
    end;
  end;
  matrixMultiplication:= res;
end;

procedure TFormUtama.affineTranslasi(Tx: Double; Ty: Double);
begin
  aTr[1,1]:= 1;
  aTr[2,2]:= 1;
  aTr[1,3]:= Tx;
  aTr[2,3]:= Ty;
end;

procedure TFormUtama.affineScaling(Sx: Double; Sy: Double);
begin
  aSc[1,1]:= Sx;
  aSc[2,2]:= Sy;
end;

procedure TFormUtama.affineRotasi(rad: Double);
var
  cosTheta: Double;
  sinTheta: Double;
begin
  cosTheta:= Cos(rad);
  sinTheta:= Sin(rad);
  aRo[1,1]:= cosTheta;
  aRo[1,2]:= (-1)*sinTheta;
  aRo[2,1]:= sinTheta;
  aRo[2,2]:= cosTheta;
end;

end.

