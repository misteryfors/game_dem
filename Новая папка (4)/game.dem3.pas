 {$reference Tao.FreeGlut.dll}
 {$reference Tao.OpenGl.dll}
 {$reference System.Drawing.dll}


uses
  System, System.Collections.Generic, System.Linq, System.Text, opengl, 
  Tao.OpenGl, Tao.FreeGlut,system.Drawing, system.drawing.imaging,
  
  loadtext,maping,snaryads;//свои модули

const
maxS=800;
CamZ=40;
size=1;
w=600;
h=480;
xs=1/2*1;
ys=1/40*1 ;
var
  o,t,t1:integer;
  ldx:real;
  camX,camY:real;
  r: single:=-3;
  
  
var
  map:ArrayType2; 



//инициализация ресурсов
procedure InitScene;
begin
  r := 0;
  //writeln(gl.glGetString(gl.GL_VERSION));
  GL.glClearColor(1, 1, 1, 1);
  
  gl.glEnable(gl.GL_TEXTURE_2D);
  gl.glEnable(gl.GL_ALPHA_TEST);
  gl.glAlphaFunc(gl.GL_GREATER, 0.0);
  LoadPictures1;
  LoadPictures2;
  LoadPictures3;
  LoadPictures4;
end;  


var s:array[0..maxS] of snaryad;

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

procedure colb(x1,y1,dir:integer);
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

procedure colision(dir:integer);
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

procedure Update;
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
end;

var p:units;//,u:player;
//процедура отрисовки

procedure attack(x,y,x2,y2:real);
begin
  //writeln(x2/24-33,' ',y2/25-16,' ',-x);
  var w:=1;
  var h:=1;
  var p:=4;
  if o=maxS then o:=0;
  if o mod 2 =0 then
  if (s[o].p=0) then begin
      s[o].r1:=(((-x+10000)*(x2/24-33))+((-y-10000)*-(y2/25-16)))/(sqrt((sqr(-((y2/(25))-16)))+sqr(x2/24-33))*sqrt((sqr(-x+10000))+sqr(-y-10000)));
      s[o].r11:=sqrt(1.1-sqr(s[o].r1));
      s[o].r2:=(((-x-10000)*(x2/24-33))+((-y-10000)*-(y2/25-16)))/(sqrt((sqr(-((y2/(25))-16)))+sqr(x2/24-33))*sqrt((sqr(-x-10000))+sqr(-y-10000)));
      s[o].r22:=sqrt(1.1-sqr(s[o].r2));
      s[o].r3:=(((-x-10000)*(x2/24-33))+((-y+10000)*-(y2/25-16)))/(sqrt((sqr(-((y2/(25))-16)))+sqr(x2/24-33))*sqrt((sqr(-x-10000))+sqr(-y+10000)));
      s[o].r33:=sqrt(1.1-sqr(s[o].r3));
      s[o].r4:=(((-x+10000)*(x2/24-33))+((-y+10000)*-(y2/25-16)))/(sqrt((sqr(-((y2/(25))-16)))+sqr(x2/24-33))*sqrt((sqr(-x+10000))+sqr(-y+10000)));
      s[o].r44:=sqrt(1.1-sqr(s[o].r4));
      //writeln(s[o].r1,' ',s[o].r2,' ',s[o].r3,' ',s[o].r4);
      s[o].w:=w;
      s[o].h:=h;
      //Writeln(x2,' ',y2);
      //Writeln((abs((abs(x2))-800)),' ',(abs((Abs(y2))-400)));
      var dx:=((x2/(24))-33)/Abs((y2/(25))-16)/10;
      var dy:=-((y2/(25))-16)/Abs((x2/(24))-33)/10;
      //Writeln(dx,' ',dy);
      if dx>1/10 then
        dx:=1/10;
      if dx<-1/10 then 
        dx:=-1/10;
      if dy>1/10 then
        dy:=1/10;
      if dy<-1/10 then 
        dy:=-1/10;
      s[o].x:=-x;
      s[o].y:=-y-1;
      s[o].dx:=(dx);
      s[o].dy:=(dy);
      s[o].p:=p;
      s[o].speed:=0.5;
      end;
      //Writeln(x,' ',y);
      inc(t);
inc(o);
end;

procedure RenderScene();
var
  i,j:integer;
begin
  gl.glLoadIdentity();
  
  glu.gluLookAt(-p.x+camX,-p.y-camY,camZ,  -p.x+camX,-p.y-camY,0,  0,1,0);
  
  gl.glClear(GL.GL_COLOR_BUFFER_bit or gl.GL_DEPTH_BUFFER_BIT);
  
begin
  gl.glTranslatef(0,0,0);
  gl.glRotated(r*10,1,0,0);
  ///gl.glScalef();

  
  for i:=round((p.y)-(35)) to round((p.Y)+35) do begin //прогрузка по вертикали В скобках менять прорисовку
for  j:=round((-p.x)-(35)) to round((-p.X)+35) do begin //прогрузка по горизонтали В скобках менять прорисовку
if (j>=0) and (i>=0) and (j<=maps) and (i<=maph) then
begin
 case map[j,i] of
  
  'g':begin
      gl.glBindTexture(gl.GL_TEXTURE_2D,PicArr2[2]); //разрушаемые
       gl.glBegin(gl.GL_QUADS); //рисуем фигуру
       gl.glTexCoord2f(j+1,i+0);  gl.glVertex3f(j+0,-i-1, 0); //первая вершина
       gl.glTexCoord2f(j+1,i-1);  gl.glVertex3f(j+0,-i+0, 0); //вторая вершина
       gl.glTexCoord2f(j+0,i-1);  gl.glVertex3f(j+1,-i+0, 0); //третья вершина
       gl.glTexCoord2f(j+0,i+0);  gl.glVertex3f(j+1,-i-1, 0); //третья вершина
       gl.glEnd;
      end;
      
        'b':begin
      gl.glBindTexture(gl.GL_TEXTURE_2D,PicArr2[3]); //не разрушаемые
       gl.glBegin(gl.GL_QUADS); //рисуем фигуру
       gl.glTexCoord2f(j+1,i+0);  gl.glVertex3f(j+0,-i-1, 0); //первая вершина
       gl.glTexCoord2f(j+1,i-1);  gl.glVertex3f(j+0,-i+0, 0); //вторая вершина
       gl.glTexCoord2f(j+0,i-1);  gl.glVertex3f(j+1,-i+0, 0); //третья вершина
       gl.glTexCoord2f(j+0,i+0);  gl.glVertex3f(j+1,-i-1, 0); //третья вершина
       gl.glEnd;
      end;
end;
end;
end;
end;

end;

begin
  gl.glRotated(180,1,0,0);
gl.glBindTexture(gl.GL_TEXTURE_2D,PicArr[P.n]);


begin
       gl.glColor4f( 1, 1, 1, 1 );
       gl.glTexEnvi(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_ENV_MODE, gl.GL_BLEND);
       gl.glBegin(gl.GL_QUADS); //рисуем фигуру
       gl.glTexCoord2f(+0,+1);  gl.glVertex3f(-p.x+0,p.y+p.h, 0); //первая вершина
       gl.glTexCoord2f(+0,+0);  gl.glVertex3f(-p.x+0,p.y+0, 0); //вторая вершина
       gl.glTexCoord2f(-1,+0);  gl.glVertex3f(-p.x+p.w,p.y+0, 0); //третья вершина
       gl.glTexCoord2f(-1,+1);  gl.glVertex3f(-p.x+p.w,p.y+p.h, 0); //третья вершина
      end;
      

  gl.glEnd;
end;

{begin
  gl.glRotated(180,1,0,0);
gl.glBindTexture(gl.GL_TEXTURE_2D,PicArr3[2]);


begin
       gl.glColor4f( 1, 1, 1, 1 );
       gl.glTexEnvi(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_ENV_MODE, gl.GL_BLEND);
       gl.glBegin(gl.GL_QUADS); //рисуем фигуру
       gl.glTexCoord2f(-1,+0);  gl.glVertex3f(-u.x+0,-u.y+u.h, 0); //первая вершина
       gl.glTexCoord2f(-1,+1);  gl.glVertex3f(-u.x+0,-u.y+0, 0); //вторая вершина
       gl.glTexCoord2f(-0,+1);  gl.glVertex3f(-u.x+u.w,-u.y+0, 0); //третья вершина
       gl.glTexCoord2f(-0,+0);  gl.glVertex3f(-u.x+u.w,-u.y+u.h, 0); //третья вершина
      end;
      

  gl.glEnd;
end;}

  begin
  gl.glRotated(180,1,0,0);
gl.glBindTexture(gl.GL_TEXTURE_2D,PicArr4[4]);
var l:=0.8;
  for var i1:=0 to maxS do 
  if (s[i1].p<>0) then begin
   //gl.glRotated(s[i1].r*360,0,0,1);
   
if (s[i1].r1<0) and (s[i1].r2>0) and (s[i1].r3>0) and (s[i1].r4<0) then //влево
begin
       gl.glBegin(gl.GL_QUADS); //рисуем фигуру 
       gl.glTexCoord2f(0,+1);   gl.glVertex3f(s[i1].x-s[i1].w*s[i1].r4,              s[i1].y-s[i1].h*s[i1].r22, 0); //первая вершина
       gl.glTexCoord2f(+1,+1);  gl.glVertex3f(s[i1].x-s[i1].w*s[i1].r3,              s[i1].y-s[i1].h*s[i1].r11, 0); //вторая вершина
       gl.glTexCoord2f(+1,0);   gl.glVertex3f(s[i1].x-s[i1].w*s[i1].r2,              s[i1].y+s[i1].h*s[i1].r44, 0); //третья вершина
       gl.glTexCoord2f(0,0);    gl.glVertex3f(s[i1].x-s[i1].w*s[i1].r1,              s[i1].y+s[i1].h*s[i1].r33, 0); //третья вершина
    
  gl.glEnd;
  end;
  
  
  if (s[i1].r1>0) and (s[i1].r2<0) and (s[i1].r3<0) and (s[i1].r4>0) then //Вправо
begin
       gl.glBegin(gl.GL_QUADS); //рисуем фигуру 
       gl.glTexCoord2f(0,+1);   gl.glVertex3f(s[i1].x-s[i1].w*s[i1].r4,              s[i1].y+s[i1].h*s[i1].r44, 0); //первая вершина
       gl.glTexCoord2f(+1,+1);  gl.glVertex3f(s[i1].x-s[i1].w*s[i1].r3,              s[i1].y+s[i1].h*s[i1].r33, 0); //вторая вершина
       gl.glTexCoord2f(+1,0);   gl.glVertex3f(s[i1].x-s[i1].w*s[i1].r2,              s[i1].y-s[i1].h*s[i1].r22, 0); //третья вершина
       gl.glTexCoord2f(0,0);    gl.glVertex3f(s[i1].x-s[i1].w*s[i1].r1,              s[i1].y-s[i1].h*s[i1].r11, 0); //третья вершина
    
  gl.glEnd;
  end;
  
    if (s[i1].r1>0) and (s[i1].r2>0) and (s[i1].r3<0) and (s[i1].r4<0) then //Вниз
begin
       gl.glBegin(gl.GL_QUADS); //рисуем фигуру 
       gl.glTexCoord2f(0,+1);   gl.glVertex3f(s[i1].x-s[i1].w*s[i1].r4,              s[i1].y+s[i1].h*s[i1].r22, 0); //первая вершина
       gl.glTexCoord2f(+1,+1);  gl.glVertex3f(s[i1].x-s[i1].w*s[i1].r3,              s[i1].y-s[i1].h*s[i1].r33, 0); //вторая вершина
       gl.glTexCoord2f(+1,0);   gl.glVertex3f(s[i1].x-s[i1].w*s[i1].r2,              s[i1].y-s[i1].h*s[i1].r44, 0); //третья вершина
       gl.glTexCoord2f(0,0);    gl.glVertex3f(s[i1].x-s[i1].w*s[i1].r1,              s[i1].y+s[i1].h*s[i1].r11, 0); //третья вершина
     
  gl.glEnd;
  end;
  
    if (s[i1].r1<0) and (s[i1].r2<0) and (s[i1].r3+0.1>0) and (s[i1].r4+0.1>0) then //Вверх
begin
  
       gl.glBegin(gl.GL_QUADS); //рисуем фигуру 
       gl.glTexCoord2f(0,+1);   gl.glVertex3f(s[i1].x-s[i1].w*s[i1].r4,              s[i1].y-s[i1].h*s[i1].r22, 0); //первая вершина
       gl.glTexCoord2f(+1,+1);  gl.glVertex3f(s[i1].x-s[i1].w*s[i1].r3,              s[i1].y+s[i1].h*s[i1].r33, 0); //вторая вершина
       gl.glTexCoord2f(+1,0);   gl.glVertex3f(s[i1].x-s[i1].w*s[i1].r2,              s[i1].y+s[i1].h*s[i1].r44, 0); //третья вершина
       gl.glTexCoord2f(0,0);    gl.glVertex3f(s[i1].x-s[i1].w*s[i1].r1,              s[i1].y-s[i1].h*s[i1].r11, 0); //третья вершина
     
  gl.glEnd;
  end;
    
//gl.glRotated(-s[i1].r,0,0,1);

end;

end;


  //gl.glFinish();
  glut.glutSwapBuffers; 
end;


procedure intialise;
begin
p:=new units((-100),(3),size,2*size);
//u:=new Player((-100),(3),size,size);
end;



procedure presskey (key:byte; x,y:integer);
begin
  //writeln(key);
  case key of
    119:if p.dy=0 then p.ddy:=-ys; //w
    246:if p.dy=0 then p.ddy:=-ys; //w
    87:if p.dy=0 then p.ddy:=-ys;
    97:p.dx:=+xs; //a
    244:p.dx:=+xs; //a
    65:p.dx:=+xs;
    115:begin p.ddy:=+ys;     for var i:=0 to maxS do
    s[i]:=new snaryad(0,0,0,0,0,0); end;//s
    251:begin p.ddy:=+ys;     for var i:=0 to maxS do
    s[i]:=new snaryad(0,0,0,0,0,0); end;//s
    83:p.ddy:=+ys;
    100:p.dx:=-xs; //d
    226:p.dx:=-xs; //d
    68:p.dx:=-xs;
    32:if p.dy=0 then p.ddy:=-ys; //space
  end;
end;

procedure presskey2 (key:byte; x,y:integer);
begin
  //writeln(key);
  case key of
    //119:p.ddy:=0; //w
    //246:p.ddy:=0; //w
    97:p.dx:=0; //a
    244:p.dx:=0; //a
    65:p.dx:=0;
    115:p.ddy:=0; //s
    251:p.ddy:=0; //s
    100:p.dx:=0; //d
    226:p.dx:=0; //d
    68:p.dx:=0;
    //32 :p.ddy:=0; //space
  end;
end;

procedure presskey3 (key, x,y:integer);
begin
  //writeln(key);
  case key of
glut.GLUT_KEY_DOWN:camY:=camY+1;
glut.GLUT_KEY_up:camY:=camY-1;
glut.GLUT_KEY_LEFT:camX:=camX-1;
glut.GLUT_KEY_RIGHT:camX:=camX+1;
//glut.GLUT_DOWN:tach;
  end;
end;

procedure presskey4 (key, state,x,y:integer);
begin
  
  case key of
glut.GLUT_LEFT_BUTTON:attack(p.x,p.y,x,y);
//glut.GLUT_RIGHT_BUTTON:p.create(x,y);
  end;
end;



procedure timer (val:integer);
begin
  if t1 mod 2 =0 then begin
  glut.glutPostRedisplay();
    P.g:=P.n;
    end;
  //u.Update;
  p.Update;
for var i:=0 to maxs do
  if s[i].p<>0 then 
begin
s[i].update;
s[i].update;
end;
  t1:=t1+1;
  glut.glutTimerFunc(20,timer,0);
end;

//процедура перенастройки
procedure Reshape(w, h: integer);
begin
  gl.glViewport(0,0,w,h);
  gl.glMatrixMode(gl.GL_PROJECTION);
  //gl.glLoadMatrixf();
  gl.glLoadIdentity();
  //gl.glMultMatrixf();
  
  //gl.glOrtho(0,w,0,h,0,100);
  
  glu.gluPerspective(45,w/h,0.1,10000);
  
gl.glMatrixMode(gl.GL_MODELVIEW);
gl.glLoadIdentity();
end;





//Основа
begin
  map:=mapgen(map);
  Glut.glutInit();
  Glut.glutInitWindowSize(1600, 800);
  Glut.glutInitWindowPosition(0, 0);
  intialise;
  P.n:=7;
  Glut.glutInitDisplayMode(Glut.GLUT_RGBA or Glut.GLUT_DOUBLE);
  Glut.glutCreateWindow('tao example');
  Glut.glutDisplayFunc(renderscene);
  Glut.glutReshapeFunc(reshape);
  glut.glutTimerFunc(5,timer,0);
  
    var nMaxAnisotropy : integer := 0;
  gl.glGetIntegerv(gl.GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT,nMaxAnisotropy);
  //writeln('max anisotropy:',nMaxAnisotropy);
  if nMaxAnisotropy>0 then
    gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT,nMaxAnisotropy);
  
    for var i:=0 to maxS do
    s[i]:=new snaryad(0,0,0,0,0,0);
    
  glut.glutKeyboardFunc(presskey);
  glut.glutKeyboardUpFunc(presskey2);
  glut.glutSpecialFunc(presskey3);
  glut.glutMouseFunc(presskey4);
  
  
  InitScene();
  Glut.glutMainLoop();
end.