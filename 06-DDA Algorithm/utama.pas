unit utama;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ColorBox, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonKeluar: TButton;
    ButtonGambar: TButton;
    ButtonHapus: TButton;
    ColorBox1: TColorBox;
    EditX1: TEdit;
    EditY1: TEdit;
    EditX2: TEdit;
    EditY2: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ScrollBox1: TScrollBox;
    Timer1: TTimer;
    procedure ButtonGambarClick(Sender: TObject);
    procedure ButtonHapusClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public
    procedure ClearScreen(Sender: TObject);
  end;

var
  Form1: TForm1;
  px, py: integer;
  x1, y1, x2, y2: double;
  dx, dy, x, y: double;
  xinc, yinc: double;
  step: double;
  i: integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormShow(Sender: TObject);
begin
  ClearScreen(Sender);
  px := Image1.Width div 2;
  py := Image1.Height div 2;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if (i <= step) then
  begin
    x := x + xinc;
    y := y + yinc;
    Image1.Canvas.Pixels[round(x) + px, py - round(y)] := ColorBox1.Selected;
    i := i + 1;
  end;
end;

procedure TForm1.ButtonHapusClick(Sender: TObject);
begin
  ClearScreen(Sender);
end;

procedure TForm1.ButtonGambarClick(Sender: TObject);
begin
  x1 := StrToFloat(EditX1.Text);
  y1 := StrToFloat(EditY1.Text);
  x2 := StrToFloat(EditX2.Text);
  y2 := StrToFloat(EditY2.Text);

  dx := abs(x2 - x1);
  dy := abs(y2 - y1);

  step := max(dx, dy);

  xinc := dx/step;
  yinc := dy/step;

  i := 0;
  x := x1;
  y := y1;
  Timer1.Enabled := not Timer1.Enabled;
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

end.

