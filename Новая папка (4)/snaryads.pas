unit snaryads;//классы
interface

uses maping;
const
size=1;
maxS=800;

var o:integer;
t,k,g,n,t1,qmap:integer;
ldx,time,dt:real;

type snaryad = class
public
w,h,x1,y1,dx,dy,r,r1,r2,r3,r4,r11,r22,r33,r44:real;
p1:integer;
x,y,m,p,lx,ly,speed:real;
constructor (dx,dy,w,h,p,speed:integer);
begin
self.x:=x;
self.y:=y;
self.lx:=lx;
self.ly:=ly;
self.dx:=dx;
self.dy:=dy;
self.w:=w;
self.h:=h;
self.p:=p;
self.speed:=speed;
end;  


procedure update;
end;

  implementation
  procedure snaryad.update;
begin
for var j:=round(x-w+0.1) to round(x+w/2-0.1) do begin  //прогрузка по вертикали В скобках 1 чтобы показать прорисовку
for var i:=round(-y-h+0.1) to round(-y+h/2-0.1) do begin
  if (i>=0)and(i<=maph)and(j>=0)and(j<=maps) and (p<>0) then begin
//writeln((i),'  ',round(j));
case map[j,i] of
  
'g':begin p:=0; map[j,i]:='0'; end;
'b':begin p:=0;  end;


end;
end;
end;
end;

  begin
x:=x+dx*speed;
y:=y+dy*speed;
//Writeln(x,' ',y);
end;
{if ((lx-800)>0) and (x>(lx+200)) then  //ограничение на полётй
  p:=0;  
if ((lx-800)<0) and (x<(lx-200)) then
  p:=0; 
if ((ly-400)>0) and (y>(ly+200)) then
  p:=0; 
if ((ly-400)<0) and (y<(ly-200)) then
  p:=0; }
end;
end.