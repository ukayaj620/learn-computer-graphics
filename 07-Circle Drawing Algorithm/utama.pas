unit utama;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonMiring: TButton;
    ButtonGambar: TButton;
    ButtonHapus: TButton;
    EditTheta: TEdit;
    EditRx: TEdit;
    EditRy: TEdit;
    EditXc: TEdit;
    EditYc: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure ButtonGambarClick(Sender: TObject);
    procedure ButtonHapusClick(Sender: TObject);
    procedure ButtonMiringClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public
    procedure ClearScreen(Sender: TObject);

  end;

var
  Form1: TForm1;
  px, py: integer;
  xc, yc: double;
  rx, ry: double;
  c: double;
  thetaInput: double;


implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormShow(Sender: TObject);
begin
  ClearScreen(Sender);
  px:= Image1.Width div 2;
  py:= Image1.Height div 2;
end;

procedure TForm1.ButtonGambarClick(Sender: TObject);
var
  theta0, theta1 : double;
  x, y: double;
  posx, posy: integer;
begin
  xc:= StrToFloat(EditXc.Text);
  yc:= StrToFloat(EditYc.Text);
  rx:= StrToFloat(EditRx.Text);
  ry:= StrToFloat(EditRy.Text);

  if rx > ry then
    c:= 1/rx
  else
    c:= 1/ry;

  theta0:= 0;
  theta1:= 2 * PI;

  while (theta0 <= theta1) do
  begin
    x:= xc + rx*Cos(theta0);
    y:= yc + ry*Sin(theta0);

    posx:= Round(x);
    posy:= Round(y);

    Image1.Canvas.Pixels[px+posx, py-posy]:= clBlack;
    theta0:= theta0 + c;
  end;
end;

procedure TForm1.ButtonHapusClick(Sender: TObject);
begin
  ClearScreen(Sender);
end;

procedure TForm1.ButtonMiringClick(Sender: TObject);
var
  theta0, theta1 : double;
  x, y: double;
  posx, posy: integer;
  thetaR, tx, ty, temp : double;
begin
  xc:= StrToFloat(EditXc.Text);
  yc:= StrToFloat(EditYc.Text);
  rx:= StrToFloat(EditRx.Text);
  ry:= StrToFloat(EditRy.Text);
  thetaInput:= StrToFloat(EditTheta.Text);

  tx:= -xc;
  ty:= -yc;

  thetaR:= thetaInput*PI/180;

  if rx > ry then
    c:= 1/rx
  else
    c:= 1/ry;

  theta0:= 0;
  theta1:= 2 * PI;

  while (theta0 <= theta1) do
  begin
    x:= xc + rx*Cos(theta0);
    y:= yc + ry*Sin(theta0);

    temp:= x;
    x:= (x*Cos(thetaR))-(y*Sin(thetaR))+(tx*cos(thetaR))-(ty*Sin(thetaR))-tx;
    y:= (temp*Sin(thetaR))+(y*Cos(thetaR))+(tx*Sin(thetaR))+(ty*Cos(thetaR))-ty;
    posx:= Round(x);
    posy:= Round(y);

    Image1.Canvas.Pixels[px+posx, py-posy]:= clBlack;
    theta0:= theta0 + c;
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

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

