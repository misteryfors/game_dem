program LazGL;

{$mode objfpc}{$H+}

uses
  gl, glu, glut, GLext, sdl, sdl_image ;
const
AppWidth = 1600;
AppHeight = 800;
maxS=800;
CamZ=40;
size=1;
w=600;
h=480;
xs=1/2*1;
ys=1/40*1 ;

var
  ScreenWidth, ScreenHeight : Integer;
  z:string;
  o,t,k,g,n,t1:integer;
  ldx,time,dt:real;
  camX,camY:real;
  r:integer;

  const
maph=40;
maps=300;
var map:array[0..maps+1,0..maph] of char;

var      PicArr: array [1..8] of gluint;       // Массивы спрайтов
     PicArr2: array [1..3] of gluint;
     PicArr3: array [1..2] of gluint;
     PicArr4: array [1..4] of gluint;

procedure mapka;
var a,b,c,s,u,j,i,z:integer;
begin
  b:=5;
      for j:=0 to maps do
        for i:=0 to maph do
        map[j,i]:='a';
  while s<maps do
  begin
    a:=Random(5);
      s:=s+1;
      for i:=s to s+5 do begin
      map[i,b]:='g';
      for z:=b to maph do
        map[i,z]:='g';
        end;
    s:=s+4;
  end;
  //for var I:=minh to maxh do begin
  //            write($'{#039}');
    //for var j:=1 to maps do
      //write(map[j,i]);
  //  write($'{#039}');
  //  if I<>maxh then
   //writeln({','});
    //end;
    //writeln(map[10,10]);
end;

//загрузка текстур
function LoadTexture (filename : string) : Integer;
var
  // Создание пространства для хранения текстуры
  TextureImage: PSDL_Surface;
  texID : integer;
  nMaxAnisotropy : Integer;
begin
  nMaxAnisotropy := 16;

  TextureImage := IMG_Load(PChar(filename));

  if ( TextureImage <> Nil ) then begin
    // Создадим текстуру
    //glEnable(GL_TEXTURE_2D);
    glGenTextures( 1, @texID );
    glBindTexture( GL_TEXTURE_2D, texID );

    glGetIntegerv(GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT, @nMaxAnisotropy);
    if (nMaxAnisotropy > 0) then
      glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAX_ANISOTROPY_EXT, nMaxAnisotropy);

      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP);
      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP);
      //glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, TextureImage^.W,TextureImage^.H, 0, GL_BGR_EXT,GL_UNSIGNED_BYTE, TextureImage^.pixels);
      //glGenerateMipmap( GL_TEXTURE_2D );

      gluBuild2DMipmaps (GL_TEXTURE_2D, GL_RGBA , TextureImage^.W,TextureImage^.H, GL_BGRA_EXT, GL_UNSIGNED_BYTE, TextureImage^.pixels);
  end;

  // Освобождаем память от картинки
  if ( TextureImage <> nil ) then
    SDL_FreeSurface( TextureImage );

  Result := texID;
end;
{function loadtexture (fliname :string): integer;
var texid: integer;
     texureimage: psdl_surface;
begin
texureimage := IMG_load(PChar(fliname))  ;

  result := texid;

end;}
procedure LoadPictures1;          //загрузка рисунков героя
begin
    PicArr[1]:=loadtexture('рисунки\shag1.png');
    PicArr[2]:=loadtexture('рисунки\shag2.png');
    PicArr[3]:=loadtexture('рисунки\shag1p.png');
    PicArr[4]:=loadtexture('рисунки\shag2p.png');
    PicArr[5]:=loadtexture('рисунки\prigok.png');
    PicArr[6]:=loadtexture('рисунки\prigok.p.png');
    PicArr[7]:=loadtexture('рисунки\stoy2.png');
    PicArr[8]:=loadtexture('рисунки\stoy.p.png');
end;
procedure LoadPictures2;     //загрузка рисунков мира
begin
    PicArr2[1]:=loadtexture('рисунки\kub.jpg');
     PicArr2[2]:=loadtexture('рисунки\k.png');
    PicArr2[3]:=loadtexture('рисунки\vopros1.gpg.png');
end;
procedure LoadPictures3;         //загрузка рисунков врагов
begin
    PicArr3[1]:=loadtexture('рисунки\vrag.grib.png');
    PicArr3[2]:=loadtexture('рисунки\vrag.grib2.png');
    end;
procedure LoadPictures4;         //загрузка рисунков врагов
begin
    PicArr4[1]:=loadtexture('рисунки\vsmah1.png');
    PicArr4[2]:=loadtexture('рисунки\vsmah2.png');
    PicArr4[3]:=loadtexture('рисунки\vsmah3.png');
    PicArr4[4]:=loadtexture('рисунки\volna.png');
    end;

//инициализация ресурсов
procedure InitScene;
begin
  r := 0;
  writeln(gl.glGetString(gl.GL_VERSION));
  GL.glClearColor(1, 1, 1, 1);

  glEnable(GL_TEXTURE_2D);
  glEnable(GL_ALPHA_TEST);
  glAlphaFunc(GL_GREATER, 0.0);
  LoadPictures1;
  LoadPictures2;
  LoadPictures3;
  LoadPictures4;
end;




type snaryad = class
public
w,h,x,dx,dy,y,p,m,lx,ly,x1,y1,r,r1,r2,r3,r4,r11,r22,r33,r44:real;
p1:integer;
procedure update;
end;



procedure snaryad.update;
label l;
var j,i:integer;
begin
for j:=round(x-0.5) to round(x+0.5) do begin  //прогрузка по вертикали В скобках 1 чтобы показать прорисовку
for i:=round(-y-0.5) to round(-y-0.5) do begin
  if (i>=0)and(i<maph)and(j>0)and(j<=maps) then begin
//writeln((i),'  ',round(j));
case map[j,i] of

'g':begin p:=0; map[j,i]:='0'; goto l; end;
'b':begin p:=0; goto l; end;


end;
end;
end;
end;
l:

  begin
x:=x+round(dx)/100;
y:=y+round(dy)/100;
end;
end;



var s:array[0..maxS] of snaryad;




type Player = class
public
x,y,dx,dy,ddy:real;
w,h:integer;
{x1,y1,}mausebutton:integer;
procedure tach(x2, y2:real);
procedure colg(x1,y1,dir:integer);
procedure colb(x1,y1,dir:integer);
procedure colision(dir:integer);
procedure Update;
{constructor create(x,y,w,h:integer);
begin
self.x:=x;
self.y:=y;
self.w:=w;
self.h:=h;}
end;


procedure Player.tach(x2, y2:real);
var p:integer;
var  dxx,dyy:real;
begin
  //writeln(x2/24-33,' ',y2/25-16,' ',-x);
   w:=1;
   h:=1;
   p:=4;
  if o=maxS then o:=0;
  if o mod 2 =0 then
  if (s[o].p=0) then begin
      s[o].r1:=(((-x+1000)*(x2/24-33))+((-y-1000)*-(y2/25-16)))/(sqrt((sqr(-((y2/(25))-16)))+sqr(x2/24-33))*sqrt((sqr(-x+1000))+sqr(-y-1000)));
      s[o].r11:=sqrt(1.1-sqr(s[o].r1));
      s[o].r2:=(((-x-1000)*(x2/24-33))+((-y-1000)*-(y2/25-16)))/(sqrt((sqr(-((y2/(25))-16)))+sqr(x2/24-33))*sqrt((sqr(-x-1000))+sqr(-y-1000)));
      s[o].r22:=sqrt(1.1-sqr(s[o].r2));
      s[o].r3:=(((-x-1000)*(x2/24-33))+((-y+1000)*-(y2/25-16)))/(sqrt((sqr(-((y2/(25))-16)))+sqr(x2/24-33))*sqrt((sqr(-x-1000))+sqr(-y+1000)));
      s[o].r33:=sqrt(1.1-sqr(s[o].r3));
      s[o].r4:=(((-x+1000)*(x2/24-33))+((-y+1000)*-(y2/25-16)))/(sqrt((sqr(-((y2/(25))-16)))+sqr(x2/24-33))*sqrt((sqr(-x+1000))+sqr(-y+1000)));
      s[o].r44:=sqrt(1.1-sqr(s[o].r4));
      //writeln(s[o].r1,' ',s[o].r2,' ',s[o].r3,' ',s[o].r4);
      s[o].w:=w;
      s[o].h:=h;
      dxx:=((x2/(24))-33);
      dyy:=-((y2/(25))-16);
      s[o].x:=-x;
      s[o].y:=-y;
      //if dx>0 then dx:=dx else dx:=dx;
      //if dy>0 then dy:=dy else dy:=dy;

      s[o].dx:=(dx);
      s[o].dy:=(dy);
      s[o].p:=p;
      end;
      inc(t);
inc(o);
end;

{procedure create(x2, y2:real);
begin
  var i:=round(x2/24-33);
  var j:=round((y2/25-16));
  writeln(i,' ',j);
  if (j>=0)and(j<map.Length)and(i>0)and(j<=map[i].Length) then begin
    map[i][j]:='g';
  end;
end;}




procedure player.colg(x1,y1,dir:integer);
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
    else if (dy<0) then begin y:=y1+size;ddy:=0; dy:=0; {map[y1 div size][x1 div size]:='0';} {e:='g';} k:=2;  end;
end;
end;
end;

procedure player.colb(x1,y1,dir:integer);
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
    else if (dy<0) then begin y:=y1+size;ddy:=0; dy:=0; {map[y1 div size][x1 div size]:='0';} {e:='g';} k:=2;  end;
end;
end;
end;

procedure player.colision(dir:integer);
var i,j:integer;
begin

for i:=round(y) to round(y+h) do begin
for j:=round(-x-1) to round(-x+w) do begin
if (i>=0)and(i<maph)and(j>0)and(j<=maps) then begin

case map[j,i] of

'g': colg(j,i,dir);
'b': colb(j,i,dir);


end;
end;
end;
end;
end;

procedure player.Update;
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


var p:player;
//процедура отрисовки
procedure RenderScene; cdecl;
var
  i,j,i1:integer;
  var l:real;
begin
  glLoadIdentity();

  gluLookAt(-p.x+camX,-p.y-camY,camZ,  -p.x+camX,-p.y-camY,0,  0,1,0);

  glClear(GL_COLOR_BUFFER_bit or GL_DEPTH_BUFFER_BIT);

begin
  glTranslatef(0,0,0);
  glRotated(r*10,1,0,0);
  ///gl.glScalef();


  for i:=round((p.y)-(35)) to round((p.Y)+35) do begin //прогрузка по вертикали В скобках менять прорисовку
for  j:=round((-p.x)-(35)) to round((-p.X)+35) do begin //прогрузка по горизонтали В скобках менять прорисовку
if (i>=0) and (j>0) and (i<maph) and (j<maps+1) then
begin
  case map[j,i] of

  'g':begin
      gl.glBindTexture(gl.GL_TEXTURE_2D,PicArr2[2]); //разрушаемые
       glBegin(gl.GL_QUADS); //рисуем фигуру
       glTexCoord2f(j+1,i+0);  glVertex3f(j+0,-i-1, 0); //первая вершина
       glTexCoord2f(j+1,i-1);  glVertex3f(j+0,-i+0, 0); //вторая вершина
       glTexCoord2f(j+0,i-1);  glVertex3f(j+1,-i+0, 0); //третья вершина
       glTexCoord2f(j+0,i+0);  glVertex3f(j+1,-i-1, 0); //третья вершина
       glEnd;
      end;

        'b':begin
      glBindTexture(gl.GL_TEXTURE_2D,PicArr2[3]); //не разрушаемые
       glBegin(gl.GL_QUADS); //рисуем фигуру
       glTexCoord2f(j+1,i+0);  glVertex3f(j+0,-i-1, 0); //первая вершина
       glTexCoord2f(j+1,i-1);  glVertex3f(j+0,-i+0, 0); //вторая вершина
       glTexCoord2f(j+0,i-1);  glVertex3f(j+1,-i+0, 0); //третья вершина
       glTexCoord2f(j+0,i+0);  glVertex3f(j+1,-i-1, 0); //третья вершина
       glEnd;
      end;
end;
end;
end;
end;

end;

begin
  glRotated(180,1,0,0);
glBindTexture(gl.GL_TEXTURE_2D,PicArr[n]);


begin
       glBegin(gl.GL_QUADS); //рисуем фигуру
       glTexCoord2f(+0,+1);  glVertex3f(-p.x+0,p.y+p.h, 0); //первая вершина
       glTexCoord2f(+0,+0);  glVertex3f(-p.x+0,p.y+0, 0); //вторая вершина
       glTexCoord2f(-1,+0);  glVertex3f(-p.x+p.w,p.y+0, 0); //третья вершина
       glTexCoord2f(-1,+1);  glVertex3f(-p.x+p.w,p.y+p.h, 0); //третья вершина
      end;


  glEnd;
end;
  begin
  glRotated(180,1,0,0);
glBindTexture(gl.GL_TEXTURE_2D,PicArr4[4]);
l:=0.8;
  for i1:=0 to maxS do
  if (s[i1].p<>0) then begin
   //gl.glRotated(s[i1].r*360,0,0,1);

if (s[i1].r1<0) and (s[i1].r2>0) and (s[i1].r3>0) and (s[i1].r4<0) then //влево
begin
       glBegin(gl.GL_QUADS); //рисуем фигуру
       glTexCoord2f(0,+1);   glVertex3f(s[i1].x-l*s[i1].r4,              s[i1].y-l*s[i1].r22, 0); //первая вершина
       glTexCoord2f(+1,+1);  glVertex3f(s[i1].x-l*s[i1].r3,              s[i1].y-l*s[i1].r11, 0); //вторая вершина
       glTexCoord2f(+1,0);   glVertex3f(s[i1].x-l*s[i1].r2,              s[i1].y+l*s[i1].r44, 0); //третья вершина
       glTexCoord2f(0,0);    glVertex3f(s[i1].x-l*s[i1].r1,              s[i1].y+l*s[i1].r33, 0); //третья вершина

  glEnd;
  end;


  if (s[i1].r1>0) and (s[i1].r2<0) and (s[i1].r3<0) and (s[i1].r4>0) then //Вправо
begin
       gl.glBegin(gl.GL_QUADS); //рисуем фигуру
       glTexCoord2f(0,+1);   glVertex3f(s[i1].x-l*s[i1].r4,              s[i1].y+l*s[i1].r44, 0); //первая вершина
       glTexCoord2f(+1,+1);  glVertex3f(s[i1].x-l*s[i1].r3,              s[i1].y+l*s[i1].r33, 0); //вторая вершина
       glTexCoord2f(+1,0);   glVertex3f(s[i1].x-l*s[i1].r2,              s[i1].y-l*s[i1].r22, 0); //третья вершина
       glTexCoord2f(0,0);    glVertex3f(s[i1].x-l*s[i1].r1,              s[i1].y-l*s[i1].r11, 0); //третья вершина

  glEnd;
  end;

    if (s[i1].r1>0) and (s[i1].r2>0) and (s[i1].r3<0) and (s[i1].r4<0) then //Вниз
begin
       glBegin(gl.GL_QUADS); //рисуем фигуру
       glTexCoord2f(0,+1);   glVertex3f(s[i1].x-l*s[i1].r4,              s[i1].y+l*s[i1].r22, 0); //первая вершина
       glTexCoord2f(+1,+1);  glVertex3f(s[i1].x-l*s[i1].r3,              s[i1].y-l*s[i1].r33, 0); //вторая вершина
       glTexCoord2f(+1,0);   glVertex3f(s[i1].x-l*s[i1].r2,              s[i1].y-l*s[i1].r44, 0); //третья вершина
       glTexCoord2f(0,0);    glVertex3f(s[i1].x-l*s[i1].r1,              s[i1].y+l*s[i1].r11, 0); //третья вершина

  glEnd;
  end;

    if (s[i1].r1<0) and (s[i1].r2<0) and (s[i1].r3+0.1>0) and (s[i1].r4+0.1>0) then //Вверх
begin

       glBegin(gl.GL_QUADS); //рисуем фигуру
       glTexCoord2f(0,+1);   glVertex3f(s[i1].x-l*s[i1].r4,              s[i1].y-l*s[i1].r22, 0); //первая вершина
       glTexCoord2f(+1,+1);  glVertex3f(s[i1].x-l*s[i1].r3,              s[i1].y+l*s[i1].r33, 0); //вторая вершина
       glTexCoord2f(+1,0);   glVertex3f(s[i1].x-l*s[i1].r2,              s[i1].y+l*s[i1].r44, 0); //третья вершина
       glTexCoord2f(0,0);    glVertex3f(s[i1].x-l*s[i1].r1,              s[i1].y-l*s[i1].r11, 0); //третья вершина

  glEnd;
  end;

//gl.glRotated(-s[i1].r,0,0,1);

end;

end;


  //gl.glFinish();
  glutSwapBuffers;
end;


procedure intialise;
begin
p:=Player.create;
p.x:=-50;
p.y:=10;
p.w:=1;
p.h:=w;
end;



procedure presskey (key:byte; x,y:integer);cdecl;
var i:integer;
begin
  writeln(key);
  case key of
    119:if p.dy=0 then p.ddy:=-ys; //w
    246:if p.dy=0 then p.ddy:=-ys; //w
    87:if p.dy=0 then p.ddy:=-ys;
    97:p.dx:=+xs; //a
    244:p.dx:=+xs; //a
    65:p.dx:=+xs;
    115:begin p.ddy:=+ys;     for i:=0 to maxS do
    s[i]:=snaryad.create; end;//s
    251:begin p.ddy:=+ys;     for i:=0 to maxS do
    s[i]:=snaryad.create; end;//s
    83:p.ddy:=+ys;
    100:p.dx:=-xs; //d
    226:p.dx:=-xs; //d
    68:p.dx:=-xs;
    32:if p.dy=0 then p.ddy:=-ys; //space
  end;
end;

procedure presskey2 (key:byte; x,y:integer);cdecl;
begin
  //writeln(key);
  case key of
    //119:p.ddy:=0; //w
    //246:p.ddy:=0; //w
    97:p.dx:=0; //a
    244:p.dx:=0; //a
    115:p.ddy:=0; //s
    251:p.ddy:=0; //s
    100:p.dx:=0; //d
    226:p.dx:=0; //d
    //32 :p.ddy:=0; //space
  end;
end;

procedure presskey3 (key, x,y:integer); cdecl;
begin
  //writeln(key);
  case key of
GLUT_KEY_DOWN:camY:=camY+1;
GLUT_KEY_up:camY:=camY-1;
GLUT_KEY_LEFT:camX:=camX-1;
GLUT_KEY_RIGHT:camX:=camX+1;
//glut.GLUT_DOWN:tach;
  end;
end;

procedure presskey4 (key, state,x,y:longint);cdecl;
begin

  case key of
GLUT_LEFT_BUTTON:p.tach(x,y);
//glut.GLUT_RIGHT_BUTTON:p.create(x,y);
  end;
end;





//процедура перенастройки
procedure Reshape(Width, Height: Integer); cdecl;
begin
  glViewport(0,0,w,h);
  glMatrixMode(GL_PROJECTION);
  //gl.glLoadMatrixf();
  glLoadIdentity;
  //gl.glMultMatrixf();

  //gl.glOrtho(0,w,0,h,0,100);

  gluPerspective(45,w/h,0.1,10000);

glMatrixMode(gl.GL_MODELVIEW);
glLoadIdentity;
end;

procedure Timer(val: integer); cdecl;
var i:integer;
begin
  if t1 mod 2 =0 then begin
  glutPostRedisplay();
    g:=n;
    end;
  p.Update;
for i:=0 to maxs do
  if s[i].p<>0 then
begin
s[i].update;
s[i].update;
end;
  t1:=t1+1;
  glutTimerFunc(40, @Timer, 0);
end;


//Основа
var nMaxAnisotropy,i : integer;
begin
mapka;
  n:=7;
  glutInit(@argc,argv);
  //glutInitWindowSize(1600, 800);
  //glutInitWindowPosition(0, 0);

  glutInitDisplayMode(GLUT_RGBA or GLUT_DOUBLE or GLUT_DEPTH);
    glutInitWindowSize(AppWidth, AppHeight);
      ScreenWidth := glutGet(GLUT_SCREEN_WIDTH);
  ScreenHeight := glutGet(GLUT_SCREEN_HEIGHT);
  glutInitWindowPosition((ScreenWidth - AppWidth) div 2, (ScreenHeight - AppHeight) div 2);
  glutCreateWindow('Lazarus OpenGL Tutorial');
  intialise;
  InitScene();
  glutDisplayFunc(@renderscene);
  glutReshapeFunc(@Reshape);
  glutTimerFunc(40, @Timer, 0);

  {nMaxAnisotropy := 0;
  glGetIntegerv(gl.GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT,nMaxAnisotropy);
  //writeln('max anisotropy:',nMaxAnisotropy);
  if nMaxAnisotropy>0 then
    glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT,nMaxAnisotropy);}

    for i:=0 to maxS do
    s[i]:=snaryad.create;

  glutKeyboardFunc(@presskey);
  glutKeyboardUpFunc(@presskey2);
  glutSpecialFunc(@presskey3);
  glutMouseFunc(@presskey4);



  glutMainLoop();
end.


