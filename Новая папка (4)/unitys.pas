unit unitys;//классы
interface

uses maping,snaryads;
const
size=1;
maxS=800;

var o:integer;
t,k,g,n,t1,qmap:integer;
ldx,time,dt:real;

type units = class
public
x,y,dx,dy,ddy:real;
w,h,n,g:integer;
constructor (x,y,w,h:integer);
begin
self.x:=x;
self.y:=y;
self.w:=w;
self.h:=h;
self.n:=n;
end;

procedure colg(x1,y1,dir:integer);

procedure colision(dir:integer);

procedure Update;

end;

implementation

procedure units.colg(x1,y1,dir:integer);
begin
if (-x+w>x1)and(-x<x1+size)and(y+h>y1)and(y<y1+size) then begin
if (dir=1) then
  begin
         if (dx<0) then begin x:=-(x1-w); end
    else if (dx>0) then begin x:=-(x1+size);  end;
    end
else
begin
  if (dir=0) then
         if (dy>0) then begin y:=y1-h;ddy:=0; dy:=0;   end
    else if (dy<0) then begin y:=y1+size;ddy:=0; dy:=0;   end;
end;
end;
end;

procedure units.colb(x1,y1,dir:integer);
begin
if (-x+w>x1)and(-x<x1+size)and(y+h>y1)and(y<y1+size) then begin
if (dir=1) then
  begin
         if (dx<0) then begin x:=-(x1-w); end
    else if (dx>0) then begin x:=-(x1+size);  end;
    end 
else
begin
  if (dir=0) then
         if (dy>0) then begin y:=y1-h;ddy:=0; dy:=0;   end
    else if (dy<0) then begin y:=y1+size;ddy:=0; dy:=0;  end;
end;
end;
end;

procedure units.colision(dir:integer);
begin

for var i:=round(y) to round(y+h) do begin
for var j:=round(-x-1) to round(-x+w) do begin
if (i>=0)and(i<=maph)and(j>=0)and(j<=maps) then begin

case map[j,i] of
  
'g': colg(j,i,dir);
'b': colb(j,i,dir);


end;
end;
end;
end;
end;

procedure units.Update;
begin
ddy:=ddy+1/1000;
dy:=dy+ddy;
dx:=dx;
x:=x+dx;
colision(1);
y:=y+dy;
colision(0);



if (dx>0) and (dy=0) then
if (g<>1) then n:=1 else n:=2;

if (dx<0) and (dy=0) then
if (g<>3) then n:=3 else n:=4;

if ((dx>0) or (ldx<>0)) and (dy<>0) then 
if (ldx>0) then n:=5 else n:=6;

if (abs(dx)<0.01) and (dy=0) then 
if (ldx<0) then n:=8 else n:=7;

if (dx<>0) and (ldx<>dx) then  
ldx:=dx;

end;

end.