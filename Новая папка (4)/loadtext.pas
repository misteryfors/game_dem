unit loadtext;//загрузка текстур
interface
 {$reference Tao.FreeGlut.dll}
 {$reference Tao.OpenGl.dll}
 {$reference System.Drawing.dll}
uses System, System.Collections.Generic, System.Linq, System.Text, opengl, 
  Tao.OpenGl, Tao.FreeGlut,system.Drawing, system.drawing.imaging;
 var PicArr: array [1..8] of integer;       // Массивы спрайтов 
     PicArr2: array [1..3] of integer;
     PicArr3: array [1..2] of integer;
     PicArr4: array [1..4] of integer;
     PicArr5: array [1..4] of integer;
function loadtexture (fliname :string): integer;
procedure LoadPictures1;
procedure LoadPictures2;
procedure LoadPictures3;
procedure LoadPictures4;
procedure LoadPictures5; 
implementation
  function loadtexture: integer;
var texid: integer;
begin
  var img : bitmap := new bitmap (fliname);
  var rect : rectangle := new rectangle (0,0,img.width,img.height);
  var img_data : BitmapData := img.lockbits (rect,imagelockmode.ReadOnly, system.Drawing.Imaging.PixelFormat.Format32bppArgb);

  gl.glGenTextures(1,texid);
  gl.glBindTexture(gl.GL_TEXTURE_2D, texID);
  glu.gluBuild2DMipmaps(gl.GL_TEXTURE_2D, GL.GL_RGBA, IMG_DATA.Width, IMG_DATA.Height,GL.GL_BGRA,gl.GL_UNSIGNED_BYTE, img_data.Scan0);
  
  img.UnlockBits(img_data);
  result := texid;
end;
procedure LoadPictures1;          //загрузка рисунков героя
begin
    PicArr[1]:=loadtexture('спрайты\shag1.png');
    PicArr[2]:=loadtexture('спрайты\shag2.png');
    PicArr[3]:=loadtexture('спрайты\shag1p.png');
    PicArr[4]:=loadtexture('спрайты\shag2p.png');
    PicArr[5]:=loadtexture('спрайты\prigok.png');
    PicArr[6]:=loadtexture('спрайты\prigok.p.png');
    PicArr[7]:=loadtexture('спрайты\stoy2.png');
    PicArr[8]:=loadtexture('спрайты\stoy.p.png');
end;
procedure LoadPictures2;     //загрузка рисунков мира
begin
    PicArr2[1]:=loadtexture('спрайты\kub.jpg');
    PicArr2[2]:=loadtexture('спрайты\k.png');
    PicArr2[3]:=loadtexture('спрайты\vopros1.gpg.png');
end;
procedure LoadPictures3;         //загрузка рисунков врагов
begin
    PicArr3[1]:=loadtexture('спрайты\vrag.grib.png');
    PicArr3[2]:=loadtexture('спрайты\vrag.grib2.png');
    end;
procedure LoadPictures4;         //загрузка рисунков врагов
begin
    PicArr4[1]:=loadtexture('спрайты\vsmah1.png');
    PicArr4[2]:=loadtexture('спрайты\vsmah2.png');
    PicArr4[3]:=loadtexture('спрайты\vsmah3.png');
    PicArr4[4]:=loadtexture('спрайты\volna.png');
    end;
procedure LoadPictures5;         //загрузка рисунков врагов
begin
    PicArr5[1]:=loadtexture('спрайты\heal.png');
    PicArr5[2]:=loadtexture('спрайты\vsmah2.png');
    PicArr5[3]:=loadtexture('спрайты\vsmah3.png');
    PicArr5[4]:=loadtexture('спрайты\volna.png');
    end;
end. 