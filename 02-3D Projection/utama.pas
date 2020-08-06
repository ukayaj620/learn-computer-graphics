unit utama;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls;

type

  { TFormUtama }

  TFormUtama = class(TForm)
    ButtonPerspektif: TButton;
    ButtonHapus: TButton;
    ButtonParalel: TButton;
    EditM: TEdit;
    EditLength: TEdit;
    EditInitX: TEdit;
    EditInitY: TEdit;
    EditInitZ: TEdit;
    EditWidth: TEdit;
    EditHeight: TEdit;
    EditP5X: TEdit;
    EditP6X: TEdit;
    EditP7X: TEdit;
    EditP8X: TEdit;
    EditP1Y: TEdit;
    EditP2Y: TEdit;
    EditP3Y: TEdit;
    EditP4Y: TEdit;
    EditP5Y: TEdit;
    EditP6Y: TEdit;
    EditP7Y: TEdit;
    EditP8Y: TEdit;
    EditP1Z: TEdit;
    EditP2Z: TEdit;
    EditP3Z: TEdit;
    EditP4Z: TEdit;
    EditP5Z: TEdit;
    EditP6Z: TEdit;
    EditP7Z: TEdit;
    EditP8Z: TEdit;
    EditP1XP: TEdit;
    EditP2XP: TEdit;
    EditP3XP: TEdit;
    EditP4XP: TEdit;
    EditP5XP: TEdit;
    EditP6XP: TEdit;
    EditP7XP: TEdit;
    EditP8XP: TEdit;
    EditP1PY: TEdit;
    EditP2PY: TEdit;
    EditAlpha: TEdit;
    EditP3PY: TEdit;
    EditP4PY: TEdit;
    EditP5PY: TEdit;
    EditP6PY: TEdit;
    EditP7PY: TEdit;
    EditP8PY: TEdit;
    EditPhi: TEdit;
    EditP1X: TEdit;
    EditP2X: TEdit;
    EditP3X: TEdit;
    EditP4X: TEdit;
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
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ScrollBox1: TScrollBox;
    TrackBarM: TTrackBar;
    TrackBarAlpha: TTrackBar;
    TrackBarPhi: TTrackBar;
    procedure ButtonHapusClick(Sender: TObject);
    procedure ButtonParalelClick(Sender: TObject);
    procedure ButtonPerspektifClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ScrollBox1Click(Sender: TObject);
    procedure TrackBarAlphaChange(Sender: TObject);
    procedure TrackBarMChange(Sender: TObject);
    procedure TrackBarPhiChange(Sender: TObject);
    procedure Draw(Sender: TObject);
  private

  public

  end;

var
  FormUtama: TFormUtama;

implementation

{$R *.lfm}

uses math;

{ TFormUtama }

type
  TPoint3D = record
    x : Double;
    y : Double;
    z : Double;
    xP : Double;
    yP : Double;
  end;

var
  P : array[1..8] of TPoint3D;
  l, w, h : Double;
  alpha, phi, M : Double;
  px, py, L1 : Double;

{ TFormUtama }

procedure TFormUtama.FormShow(Sender: TObject);
begin
  Image1.Canvas.Brush.Color := clWhite;
  Image1.Canvas.Brush.Style := bsSolid;
  px := Image1.Width div 2;
  py := Image1.Height div 2;
  Image1.Canvas.Rectangle(0, 0, Image1.Width, Image1.Height);
  Image1.Canvas.Pen.Color := clBlack;
  Image1.Canvas.Pen.Style := psDash;
  Image1.Canvas.MoveTo(round(px), 0);
  Image1.Canvas.LineTo(round(px), Image1.Height);
  Image1.Canvas.MoveTo(0, round(py));
  Image1.Canvas.LineTo(Image1.Width, round(py));
  TrackBarAlpha.Position:= 60;
  TrackBarPhi.Position:= -30;
  TrackBarM.Position:= 398;
  EditAlpha.Text:= IntToStr(TrackBarAlpha.Position);
  EditPhi.Text:= IntToStr((-1) * TrackBarPhi.Position);
  EditM.Text:= IntToStr(TrackBarM.Position);
end;

procedure TFormUtama.ScrollBox1Click(Sender: TObject);
begin

end;

procedure TFormUtama.TrackBarAlphaChange(Sender: TObject);
begin
  EditAlpha.Text:= IntToStr(TrackBarAlpha.Position);
  ButtonHapusClick(Sender);
  ButtonParalelClick(Sender);
end;

procedure TFormUtama.TrackBarMChange(Sender: TObject);
begin
  EditM.Text:= IntToStr(TrackBarM.Position);
  ButtonHapusClick(Sender);
  ButtonPerspektifClick(Sender);
end;

procedure TFormUtama.TrackBarPhiChange(Sender: TObject);
begin
  EditPhi.Text:= IntToStr((-1) * TrackBarPhi.Position);
  ButtonHapusClick(Sender);
  ButtonParalelClick(Sender);
end;

procedure TFormUtama.ButtonParalelClick(Sender: TObject);
var
  X, Y, Z : Double;
  i : integer;
  tempX, tempY, tempZ, tempXP, tempYP : TEdit;
begin
  l := StrToInt(EditLength.Text);
  w := StrToInt(EditWidth.Text);
  h := StrToInt(EditHeight.Text);

  alpha := (StrToFloat(EditAlpha.Text))*PI/180;
  phi := (StrToFloat(EditPhi.Text))*PI/180;

  X := StrToFloat(EditInitX.Text);
  Y := StrToFloat(EditInitY.Text);
  Z := StrToFloat(EditInitZ.Text);

  L1 := 1/Tan(alpha);

  P[1].x := X;
  P[1].y := Y;
  P[1].z := Z;

  P[2].x := P[1].x + l;
  P[2].y := P[1].y;
  P[2].z := P[1].z;

  P[3].x := P[1].x + l;
  P[3].y := P[1].y + h;
  P[3].z := P[1].z;

  P[4].x := P[1].x;
  P[4].y := P[1].y + h;
  P[4].z := P[1].z;

  P[5].x := P[1].x;
  P[5].y := P[1].y;
  P[5].z := P[1].z + w;

  P[6].x := P[5].x + l;
  P[6].y := P[5].y;
  P[6].z := P[5].z;

  P[7].x := P[5].x + l;
  P[7].y := P[5].y + h;
  P[7].z := P[5].z;

  P[8].x := P[5].x;
  P[8].y := P[5].y + h;
  P[8].z := P[5].z;

  for i := 1 to 8 do
  begin
    P[i].xP := P[i].x + P[i].z * L1 * Cos(phi);
    P[i].yP := P[i].y + P[i].z * L1 * Sin(phi);
  end;

  for i := 1 to 8 do
  begin
    tempX:= TEdit(FormUtama.FindComponent('EditP' + IntToStr(i) + 'X'));
    tempX.Text:= FloatToStr(P[i].x);

    tempY:= TEdit(FormUtama.FindComponent('EditP' + IntToStr(i) + 'Y'));
    tempY.Text:= FloatToStr(P[i].y);

    tempZ:= TEdit(FormUtama.FindComponent('EditP' + IntToStr(i) + 'Z'));
    tempZ.Text:= FloatToStr(P[i].z);

    tempXP:= TEdit(FormUtama.FindComponent('EditP' + IntToStr(i) + 'XP'));
    tempXP.Text:= IntToStr(round(P[i].xP));

    tempYP:= TEdit(FormUtama.FindComponent('EditP' + IntToStr(i) + 'PY'));
    tempYP.Text:= IntToStr(round(P[i].yP));
  end;

  Draw(Sender);

end;

procedure TFormUtama.ButtonPerspektifClick(Sender: TObject);
var
  X, Y, Z : Double;
  i : integer;
  tempX, tempY, tempZ, tempXP, tempYP : TEdit;
begin
  l := StrToInt(EditLength.Text);
  w := StrToInt(EditWidth.Text);
  h := StrToInt(EditHeight.Text);

  X := StrToFloat(EditInitX.Text);
  Y := StrToFloat(EditInitY.Text);
  Z := StrToFloat(EditInitZ.Text);

  M := StrToFloat(EditM.Text);

  P[1].x := X;
  P[1].y := Y;
  P[1].z := Z;

  P[2].x := P[1].x + l;
  P[2].y := P[1].y;
  P[2].z := P[1].z;

  P[3].x := P[1].x + l;
  P[3].y := P[1].y + h;
  P[3].z := P[1].z;

  P[4].x := P[1].x;
  P[4].y := P[1].y + h;
  P[4].z := P[1].z;

  P[5].x := P[1].x;
  P[5].y := P[1].y;
  P[5].z := P[1].z + w;

  P[6].x := P[5].x + l;
  P[6].y := P[5].y;
  P[6].z := P[5].z;

  P[7].x := P[5].x + l;
  P[7].y := P[5].y + h;
  P[7].z := P[5].z;

  P[8].x := P[5].x;
  P[8].y := P[5].y + h;
  P[8].z := P[5].z;

  for i := 1 to 8 do
  begin
    if (P[i].z <> M) and (M <> 0) then
    begin
      P[i].xP := P[i].x / (1 - P[i].z/M);
      P[i].yP := P[i].y / (1 - P[i].z/M);
    end;
  end;

  for i := 1 to 8 do
  begin
    tempX:= TEdit(FormUtama.FindComponent('EditP' + IntToStr(i) + 'X'));
    tempX.Text:= FloatToStr(P[i].x);

    tempY:= TEdit(FormUtama.FindComponent('EditP' + IntToStr(i) + 'Y'));
    tempY.Text:= FloatToStr(P[i].y);

    tempZ:= TEdit(FormUtama.FindComponent('EditP' + IntToStr(i) + 'Z'));
    tempZ.Text:= FloatToStr(P[i].z);

    tempXP:= TEdit(FormUtama.FindComponent('EditP' + IntToStr(i) + 'XP'));
    tempXP.Text:= IntToStr(round(P[i].xP));

    tempYP:= TEdit(FormUtama.FindComponent('EditP' + IntToStr(i) + 'PY'));
    tempYP.Text:= IntToStr(round(P[i].yP));
  end;

  Draw(Sender);

end;

procedure TFormUtama.ButtonHapusClick(Sender: TObject);
begin
  Image1.Canvas.Brush.Color := clWhite;
  Image1.Canvas.Brush.Style := bsSolid;
  px := Image1.Width div 2;
  py := Image1.Height div 2;
  Image1.Canvas.Rectangle(0, 0, Image1.Width, Image1.Height);
  Image1.Canvas.Pen.Color := clBlack;
  Image1.Canvas.Pen.Style := psDash;
  Image1.Canvas.MoveTo(round(px), 0);
  Image1.Canvas.LineTo(round(px), Image1.Height);
  Image1.Canvas.MoveTo(0, round(py));
  Image1.Canvas.LineTo(Image1.Width, round(py));
end;

procedure TFormUtama.Draw(Sender: TObject);
var
  i: integer;
begin
  Image1.Canvas.Pen.Color := clRed;
  Image1.Canvas.Pen.Style := psSolid;
  Image1.Canvas.Pen.Width := 2;

  Image1.Canvas.MoveTo(round(px + P[4].xP), round(py - P[4].yP));
  for i := 1 to 4 do
  begin
    Image1.Canvas.LineTo(round(px + P[i].xP), round(py - P[i].yP))
  end;

  Image1.Canvas.Pen.Color := clBlue;
  Image1.Canvas.Pen.Style := psSolid;
  Image1.Canvas.Pen.Width := 2;

  Image1.Canvas.MoveTo(round(px + P[8].xP), round(py - P[8].yP));
  for i := 5 to 8 do
  begin
    Image1.Canvas.LineTo(round(px + P[i].xP), round(py - P[i].yP))
  end;

  Image1.Canvas.Pen.Color := clGreen;
  Image1.Canvas.Pen.Style := psSolid;
  Image1.Canvas.Pen.Width := 2;

  for i := 1 to 2 do
  begin
    Image1.Canvas.MoveTo(round(px + P[i].xP), round(py - P[i].yP));
    Image1.Canvas.LineTo(round(px + P[i+4].xP), round(py - P[i+4].yP))
  end;

  Image1.Canvas.Pen.Color := clBlack;
  Image1.Canvas.Pen.Style := psSolid;
  Image1.Canvas.Pen.Width := 2;

  for i := 3 to 4 do
  begin
    Image1.Canvas.MoveTo(round(px + P[i].xP), round(py - P[i].yP));
    Image1.Canvas.LineTo(round(px + P[i+4].xP), round(py - P[i+4].yP))
  end;
end;

end.

