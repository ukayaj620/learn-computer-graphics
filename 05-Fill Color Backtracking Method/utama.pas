unit utama;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonKeluar: TButton;
    ButtonHapus: TButton;
    ButtonLingkaran: TButton;
    Image1: TImage;
    procedure ButtonHapusClick(Sender: TObject);
    procedure ButtonLingkaranClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
  private

  public
    procedure ClearScreen(Sender: TObject);
    procedure CustomFillColor(Image: TImage; x,y: integer; wC, wF: TColor);
  end;

var
  Form1: TForm1;
  px, py: integer;
  xFill, yFill: integer;
  fillColorOnProgress: boolean;
  wCurrent: TColor;

implementation

{$MAXSTACKSIZE 304857600}
{$R *.lfm}

{ TForm1 }

procedure TForm1.FormShow(Sender: TObject);
begin
  ClearScreen(Sender);
  px := Image1.Width div 2;
  py := Image1.Height div 2;
end;

procedure TForm1.Image1DblClick(Sender: TObject);
begin
  if not fillColorOnProgress then
  begin
    fillColorOnProgress := true;
    wCurrent := Image1.Canvas.Pixels[xFill,yFill];
    customFillColor(Image1, xFill, yFill, Image1.Canvas.Pixels[xFill,yFill], clYellow);
    fillColorOnProgress := false;
  end;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  xFill := X;
  yFill := Y;
end;

procedure TForm1.ButtonHapusClick(Sender: TObject);
begin
  ClearScreen(Sender);
end;

procedure TForm1.ButtonLingkaranClick(Sender: TObject);
var
  x1, y1, x2, y2: integer;
begin
  x1 := 100;
  y1 := 100;
  x2 := 200;
  y2 := 200;
  Image1.Canvas.Pen.Color := clRed;
  Image1.Canvas.Pen.Style := psSolid;
  Image1.Canvas.Ellipse(x1 + px,py - y1,x2 + px,py - y2);
end;

procedure TForm1.ClearScreen(Sender: TObject);
begin
  Image1.Canvas.Brush.Color := clWhite;
  Image1.Canvas.Rectangle(0,0,Image1.Width, Image1.Height);
  Image1.Canvas.Pen.Color := clBlack;
  Image1.Canvas.Pen.Style := psDash;
  Image1.Canvas.MoveTo(Image1.Width div 2,0);
  Image1.Canvas.LineTo(Image1.Width div 2,Image1.Height);
  Image1.Canvas.MoveTo(0,Image1.Height div 2);
  Image1.Canvas.LineTo(Image1.Width,Image1.Height div 2);
end;

procedure TForm1.CustomFillColor(Image: TImage; x,y: integer; wC, wF: TColor);
begin
  if (x > 0) AND (x < Image.Width) AND (y > 0) AND (y < Image.Height)
  AND (Image.Canvas.Pixels[x,y] = wC)
  then
  begin
    Image.Canvas.Pixels[x,y] := wF;
    if Image.Canvas.Pixels[x,y+1] = wC then
      customFillColor(Image, x, y+1, wC, wF);
    if Image.Canvas.Pixels[x+1,y] = wC then
      customFillColor(Image, x+1, y, wC, wF);
    if Image.Canvas.Pixels[x-1,y] = wC then
      customFillColor(Image, x-1, y, wC, wF);
    if Image.Canvas.Pixels[x,y-1] = wC then
      customFillColor(Image, x, y-1, wC, wF);
  end;
end;

end.

