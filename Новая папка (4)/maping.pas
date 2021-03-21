unit maping;



interface
  const
maph=40;
maps=302;
maxdet=50;
mapr=10; 
type
 ArrayType1 = ARRAY[0..maxdet,0..maxdet] OF char;
 ArrayType2 = ARRAY[0..maps,0..maph] OF char;
var
  qmap:integer;
  map:ArrayType2; 
  mapa:ArrayType2;
    mapdetals:array[1..mapr] of arraytype1;
    mapdetalsS:array[1..mapr] of integer;
    mapdetalsH:array[1..mapr] of integer;
function mapgen(mapa:ArrayType2):ArrayType2;
implementation

procedure loadmapdetals;
    var
    f: file of char;
    c: char;
    err:integer;
    i,j,s,s1,h,h1,q:integer;
begin
      assign (f, 'C:\PABCWork.NET\Project1\mapdetal.txt');
    reset (f);
    while not eof (f) do begin
      inc(q);
            s:=s*10;
      val(c,s1,err);
      s:=s+s1;
      read(f,c);
    while c<>' ' do begin
      s:=s*10;
      val(c,s1,err);
      s:=s+s1;
      read(f,c);
    end;
    read(f,c);
    val(c,h1,err);
    h:=h+h1;
    read(f,c);
    while (c<>' ') and (c<>#13) do begin
      h:=h*10;
      val(c,h1,err);
      h:=h+h1;
      read(f,c);
    end;
    Writeln(c);
         read(f,c);
    for j:=1 to h do begin
     
    for i:=1 to s+2 do begin
      if not Eof (f) then
     read(f,mapdetals[q][j,i]);
     //WRITE(mapdetals[q][j,i]);
    end;
    end;
    mapdetalsH[q]:=h;
    h:=0;
    mapdetalsS[q]:=s;
    s:=0;
    if not eof (f) then
      read(f,c);

    end;
    qmap:=q;
end;

function ogran(mapa:ArrayType2):ArrayType2;
var i,j:integer;
begin
    for i:=1 to maph do
      mapa[0,i]:='b';
        for i:=1 to maph do
      mapa[maps,i]:='b';
        for j:=1 to maps do 
          mapa[j,0]:='b';
                for j:=1 to maps do 
          mapa[j,maph]:='b';
                Result:=mapa;
end;

function mapgen:arraytype2;
var a,i,j,h,s:integer;

begin
 loadmapdetals; 
          for j:=1 to maps do 
    for i:=1 to maph do 
      mapa[j,i]:='a';
s:=0;
h:=20;   
while s<maps-maxdet do begin
A:=PABCSystem.Random(qmap)+1;
begin
   for j:=1 to mapdetalsH[a] do begin
    for i:=1 to mapdetalsS[a] do begin
     mapa[s+i-1,H+j]:=mapdetals[a][j,i];

     {for j1:=1 to maps do 
    for i1:=1 to maph do 
      Write(mapdetals[a][j,i]);}
    end;
    end;
    end;

s:=s+mapdetalsS[a];
end;
 mapa:=ogran(mapa);        
Result:=mapa;
end;
end.
