program admin;
{IS : program meminta pengguna untuk mengisi data username dan password untuk kemudian divalidasi
FS : jika valid, pengguna dapat masuk ke mode admin untuk mengganti/menambah data produk, order, dan customer
Author : Ubassy Abdillah, Dzakyta Afuzagani, Akhmad Fadilah Ramadhan, Mohammad Zakie Faiz Rahiemy}
uses crt, dos;
type
  beli = record
    kodeb,namab : string;
    jmlhb, hargab : integer;
end;
type
  barang = record
    namao,kodeo,kat,des: string;
    jmlho,hargao : integer;
end;
type
  pembeli = record
    namap,idp,alm,notelp : string;
end;
type
  struk =record
    id,stat : string;
    be : array [1..10] of beli;
    jum : integer;
    total : real;
end;
var
  Y,M,D,DOW:WORD;
  jp,js,jb,kode,menu,count:integer;
  income:real;
  pass,user,pil:string;
  keluar : boolean;
  arsipo : file of barang;
  arsips : file of struk;
  arsipp : file of pembeli;
  b:array [1..50] of barang;
  s:array [1..1000] of struk;
  p:array[1..100] of pembeli;

Procedure login(Var S,user:String);
{IS : pengguna diminta mengisi username dan password
FS : jika data valid, pengguna dapat memasuki menu selanjutnya
Author : Mohammad Zakie Faiz Rahiemy}
Var 
  Ch : Char; 
Begin 
  getdate(y,m,d,dow);
     gotoxy(1,1);writeln('+------------------------------------------------------------------------------+');
     gotoxy(1,2);writeln('|            ___       ________  ________  ________  ___  __                   |');
     gotoxy(1,3);writeln('|           |\  \     |\   __  \|\   __  \|\   __  \|\  \|\  \                 |');
     gotoxy(1,4);writeln('|           \ \  \    \ \  \|\  \ \  \|\  \ \  \|\  \ \  \/  /|_               |');
     gotoxy(1,5);writeln('|            \ \  \    \ \   __  \ \   ____\ \   __  \ \   ___  \              |');
     gotoxy(1,6);writeln('|             \ \  \____\ \  \ \  \ \  \___|\ \  \ \  \ \  \\ \  \             |');
     gotoxy(1,7);writeln('|              \ \_______\ \__\ \__\ \__\    \ \__\ \__\ \__\\ \__\            |');
     gotoxy(1,8);writeln('|               \|_______|\|__|\|__|\|__|     \|__|\|__|\|__| \|__|            |');
     gotoxy(1,9);writeln('|                 01001100  01000001  01010000  01000001  01001011             |');
     gotoxy(1,10);writeln('+------------------------------------------------------------------------------+');
     gotoxy(1,11);writeln('|                                                                              |');
     gotoxy(1,12);writeln('|                                                                              |');
     gotoxy(1,13);writeln('|');gotoxy(80,13);writeln('|');
     gotoxy(1,14);writeln('+------------------------------------------------------------------------------+');
     gotoxy(3,11);write('Username : ');
     gotoxy(3,12);writeln('Password : ');
     user:='admin';
     pass:='meledak';

     gotoxy(14,11);readln(user);
     gotoxy(14,12);
     Ch := #0;
     S := '';
     Repeat
    If KeyPressed then 
      Begin 
      Ch := ReadKey; 
      If Ch = #0 then ReadKey
      else if (Ch = #8) and (Length(S) > 0) then
        Begin 
        S := Copy(S,1,Length(S)-1); 
        GotoXY(WhereX-1,WhereY); 
        ClrEol 
        end 
      else if Ch <> #13 then
        Begin 
        S := S + Ch; 
        Write('*') 
        end 
      end 
  Until Ch = #13; 
  Writeln 
end;

function fincome(s:array of struk;js:integer):real;
{IS : menerima masukan data order
FS : menjumlahkan total harga dari semua data order
Author : Mohammad Zakie Faiz Rahiemy}
var
   i:integer;
   tot:real;
begin
     tot:=0;
     js:=js-1;
     for i:=1 to js do
     begin
          tot:= tot+ s[i].total;
     end;
     tot:=tot/1000000;
     fincome:=tot;
end;

procedure home();
{IS : tampilan awal menu admin, menampilkan data statistik terbaru. pengguna dapat mengisi kode perintah
FS : akan pindah ke menu sesuai perintah yang diminta pengguna
Author : Mohammad Zakie Faiz Rahiemy}
begin
     getdate(y,m,d,dow);
     gotoxy(1,1);writeln('+------------------------------------------------------------------------------+');
     gotoxy(1,2);writeln('|            ___       ________  ________  ________  ___  __                   |');
     gotoxy(1,3);writeln('|           |\  \     |\   __  \|\   __  \|\   __  \|\  \|\  \                 |');
     gotoxy(1,4);writeln('|           \ \  \    \ \  \|\  \ \  \|\  \ \  \|\  \ \  \/  /|_               |');
     gotoxy(1,5);writeln('|            \ \  \    \ \   __  \ \   ____\ \   __  \ \   ___  \              |');
     gotoxy(1,6);writeln('|             \ \  \____\ \  \ \  \ \  \___|\ \  \ \  \ \  \\ \  \             |');
     gotoxy(1,7);writeln('|              \ \_______\ \__\ \__\ \__\    \ \__\ \__\ \__\\ \__\            |');
     gotoxy(1,8);writeln('|               \|_______|\|__|\|__|\|__|     \|__|\|__|\|__| \|__|            |');
     gotoxy(1,9);writeln('|                 01001100  01000001  01010000  01000001  01001011             |');
     gotoxy(1,10);writeln('+------------+-------------+---------------+--------------------+--------------+');
     gotoxy(1,11);writeln('|   [H]OME   |  P[R]ODUCT  |    [O]RDER    |     [C]USTOMER     |   [S]EARCH   |');
     gotoxy(1,12);writeln('+------------+-------------+---------------+--------------------+--------------+');
     gotoxy(1,13);writeln('|                                                                              |');
     gotoxy(1,14);writeln('|                                                                              |');
     gotoxy(1,15);writeln('|                                                                              |');
     gotoxy(1,16);writeln('|                                                                              |');
     gotoxy(1,17);writeln('|                                                                              |');
     gotoxy(1,18);writeln('|                                                                              |');
     gotoxy(1,19);writeln('|                                                                              |');
     gotoxy(1,20);writeln('|                                                                              |');
     gotoxy(1,21);writeln('|                                                                              |');
     gotoxy(1,22);writeln('|                                                                              |');
     gotoxy(1,23);writeln('|                                                                              |');
     gotoxy(1,24);writeln('|                                                                              |');
     gotoxy(1,25);writeln('|                                                                              |');
     gotoxy(1,26);writeln('|                                                                              |');
     gotoxy(1,27);writeln('|                                                                              |');
     gotoxy(1,28);writeln('+------------------------------------------------------------------------------+');
     gotoxy(3,14);writeln('Welcome Back, Admin!');
     gotoxy(3,15);writeln('Today : ',D,'-',M,'-',Y);
     gotoxy(3,17);writeln('Whats New?');
     gotoxy(3,18);writeln('Registered Products  : ',jb-1,' items');
     gotoxy(3,19);writeln('Registered Customers : ',jp-1,' persons');
     gotoxy(3,20);writeln('Order Recorded       : ',js-1,' orders');
     gotoxy(3,22);writeln('Income and Outcome   : ');
     income:=fincome(s,js);
     gotoxy(3,21);writeln('Income               : Rp ',income:0:2,' Million');
     gotoxy(3,22);writeln('Outcome              : Rp 0.00');
end;

Procedure product(var ob : array of barang;var k:integer; var jo : integer);
{IS : menampilkan daftar produk
FS : admin dapat mengedit, menambah, atau menghapus produk baru
Author : Mohammad Zakie Faiz Rahiemy}
  var
    pil,id : string;
    n,i,j,ketemu,pake,kata,butuh,baris : integer;
    ganti,view:boolean;
    del:char;
  begin
    n := 1;
    view := false;
    repeat
      textcolor(15);
      ganti := false;
      k := 0;
      ketemu := 0;
      clrscr;
      gotoxy(1,1);writeln('+------------------------------------------------------------------------------+');
     gotoxy(1,2);writeln('|            ___       ________  ________  ________  ___  __                   |');
     gotoxy(1,3);writeln('|           |\  \     |\   __  \|\   __  \|\   __  \|\  \|\  \                 |');
     gotoxy(1,4);writeln('|           \ \  \    \ \  \|\  \ \  \|\  \ \  \|\  \ \  \/  /|_               |');
     gotoxy(1,5);writeln('|            \ \  \    \ \   __  \ \   ____\ \   __  \ \   ___  \              |');
     gotoxy(1,6);writeln('|             \ \  \____\ \  \ \  \ \  \___|\ \  \ \  \ \  \\ \  \             |');
     gotoxy(1,7);writeln('|              \ \_______\ \__\ \__\ \__\    \ \__\ \__\ \__\\ \__\            |');
     gotoxy(1,8);writeln('|               \|_______|\|__|\|__|\|__|     \|__|\|__|\|__| \|__|            |');
     gotoxy(1,9);writeln('|                 01001100  01000001  01010000  01000001  01001011             |');
     gotoxy(1,10);writeln('+------------+-------------+---------------+--------------------+--------------+');
     gotoxy(1,11);writeln('|   [H]OME   |  P[R]ODUCT  |    [O]RDER    |     [C]USTOMER     |   [S]EARCH   |');
     gotoxy(1,12);writeln('+--+--------+------------------------+-------+-------------+-------------------+');
     gotoxy(1,13);writeln('|No|  id    |       Item Name        | Stock |    Price    |      Category     |');
     gotoxy(1,14);writeln('+--+--------+------------------------+-------+-------------+-------------------+');
     gotoxy(1,15);writeln('|                                                                              |');
     gotoxy(1,16);writeln('|                                                                              |');
     gotoxy(1,17);writeln('|                                                                              |');
     gotoxy(1,18);writeln('|                                                                              |');
     gotoxy(1,19);writeln('|                                                                              |');
     gotoxy(1,20);writeln('|                                                                              |');
     gotoxy(1,21);writeln('|                                                                              |');
     gotoxy(1,22);writeln('|                                                                              |');
     gotoxy(1,23);writeln('|                                                                              |');
     gotoxy(1,24);writeln('|                                                                              |');
     gotoxy(1,25);writeln('|                                                                              |');
     gotoxy(1,26);writeln('|                                                                              |');
     gotoxy(1,27);writeln('|                                                                              |');
     gotoxy(1,28);writeln('+------------------------------------------------------------------------------+');
     gotoxy(1,29);writeln('Select Menu : ');
      if ((jo-n) div 13 = 0) then
      begin
        for i := 1 to ((jo-n) mod 13) do
        begin
          gotoxy(1,i+14);write('|',i);gotoxy(4,i+14);write('| ',ob[i+n-1].kodeo);gotoxy(13,i+14);write('| ',ob[i+n-1].namao);
          gotoxy(38,i+14);write('| ',ob[i+n-1].jmlho);gotoxy(46,i+14);write('| Rp. ',ob[i+n-1].hargao);
          gotoxy(60,i+14);write('| ',ob[i+n-1].kat);gotoxy(80,i+14);write('|');
        end;
        for i := ((jo-n) mod 13) to 13 do
        begin
          gotoxy(1,i+14);write('|');gotoxy(4,i+14);write('|');gotoxy(13,i+14);write('|');
          gotoxy(38,i+14);write('|');gotoxy(46,i+14);write('|');gotoxy(60,i+14);write('|');
          gotoxy(80,i+14);write('|');
        end;
      end
      else
        for i := 1 to 13 do
        begin
          gotoxy(1,i+14);write('|',i);gotoxy(4,i+14);write('| ',ob[i+n-1].kodeo);gotoxy(13,i+14);write('| ',ob[i+n-1].namao);
          gotoxy(38,i+14);write('| ',ob[i+n-1].jmlho);gotoxy(46,i+14);write('| Rp. ',ob[i+n-1].hargao);
          gotoxy(60,i+14);write('| ',ob[i+n-1].kat);gotoxy(80,i+14);write('|');
        end;
      if (view=false) then
      begin
        gotoxy(1,30);write('[P]REV                [E]DIT [I]NSERT [D]ELETE S[T]OCK                   [N]EXT');
        gotoxy(77,29);write((n div 13)+1,'/',(jo div 13)+1);
        gotoxy(1,29);write('Select Menu : ');readln(pil);
      end
      else
      begin
        gotoxy(1,30);write('[P]REV                [E]DIT [I]NSERT [D]ELETE S[T]OCK                   [N]EXT');
        gotoxy(77,29);write((n div 13)+1,'/',(jo div 13)+1);
        gotoxy(1,29);write('Item ID : ');readln(pil);
      end;
      if (((pil='d')or(pil='D'))and(view=false)) then
      begin
        gotoxy(1,29);clreol;write('Item ID : ');readln(id);
          ketemu:=0;
          for i := 1 to jo do
          begin
            if (ob[i].kodeo=id) then
              ketemu := i;
          end;
          if (ketemu = 0) then
          begin
             gotoxy(25,29);clreol;textcolor(red);write('Invalid Input');readln;
             textcolor(15);gotoxy(25,29);clreol;
          end
          else
          begin
            clrscr;
            writeln('+------------------------------------------------------------------------------+');
            gotoxy(1,4);write('|');gotoxy(80,8);write('|');
            gotoxy(80,2);write('|');gotoxy(80,9);write('|');
            gotoxy(80,3);write('|');gotoxy(80,4);write('|');
            gotoxy(80,5);write('|');
            gotoxy(80,6);write('|');
            gotoxy(80,7);write('|');
            gotoxy(1,2);writeln('|            ___       ________  ________  ________  ___  __');
            gotoxy(1,3);writeln('|           |\  \     |\   __  \|\   __  \|\   __  \|\  \|\  \');
            gotoxy(1,4);writeln('|           \ \  \    \ \  \|\  \ \  \|\  \ \  \|\  \ \  \/  /|_');
            gotoxy(1,5);writeln('|            \ \  \    \ \   __  \ \   ____\ \   __  \ \   ___  \');
            gotoxy(1,6);writeln('|             \ \  \____\ \  \ \  \ \  \___|\ \  \ \  \ \  \\ \  \');
            gotoxy(1,7);writeln('|              \ \_______\ \__\ \__\ \__\    \ \__\ \__\ \__\\ \__\');
            gotoxy(1,8);writeln('|               \|_______|\|__|\|__|\|__|     \|__|\|__|\|__| \|__|');
            gotoxy(1,9);writeln('|                 01001100  01000001  01010000  01000001  01001011');
            gotoxy(1,10);write('+------------+-------------+---------------+--------------------+--------------+');
            gotoxy(1,11);write('|   [H]OME   |  P[R]ODUCT  |    [O]RDER    |     [C]USTOMER     |   [S]EARCH   |');
            gotoxy(1,12);write('+------------+-------------+---------------+-----------------------------------+');
            gotoxy(1,13);write('| Item ID    |             | Item Name     |                                   |');       {deskripsi 42 karakter}
            gotoxy(1,14);write('+------------+-------------+---------------+--------------+-------+------------+');
            gotoxy(1,15);write('| Price      |             | Category      |              | Stock |            |');
            gotoxy(1,16);write('+------------+-------------+---------------+--------------+-------+------------+');
            gotoxy(1,17);write('| Deskripsi  |');
            gotoxy(1,18);write('+------------+');
            gotoxy(1,19);writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');
            write('+------------------------------------------------------------------------------+');
            gotoxy(1,29);write('Are you really want to delete this product? (y/n) : ');
            gotoxy(80,17);write('|');
            gotoxy(80,18);write('|');gotoxy(80,19);write('|');
            gotoxy(80,20);write('|');gotoxy(80,21);write('|');
            gotoxy(80,22);write('|');gotoxy(80,23);write('|');
            gotoxy(80,24);write('|');gotoxy(80,25);write('|');
            gotoxy(80,26);write('|');gotoxy(80,27);write('|');
            gotoxy(16,13);write(ob[ketemu].kodeo);
            gotoxy(46,13);write(ob[ketemu].namao);
            gotoxy(16,15);write('Rp ',ob[ketemu].hargao);
            gotoxy(46,15);write(ob[ketemu].kat);
            gotoxy(69,15);write(ob[ketemu].jmlho);
            gotoxy(3,19);
            pake := 0;
            kata := 0;
            butuh := 0;
            baris:=19;
            for i := 1 to length(ob[ketemu].des) do
            begin
                 j := i;
                 if (ob[ketemu].des[j]=' ') then
                 begin
                      butuh := 0;
                      j := j + 1 ;
                      pake := kata;
                      while (ob[ketemu].des[j]<>' ') do
                      begin
                           butuh := butuh + 1;
                           j := j + 1;
                      end;
                 end;
                 if (pake+butuh<76) then
                 begin
                      write(ob[ketemu].des[i]);
                      kata := kata + 1;
                 end
                 else
                 begin
                      baris:=baris+1;
                      gotoxy(2,baris);
                      write(ob[ketemu].des[i]);
                      kata := 1;
                      pake := 0;
                 end;
            end;
            gotoxy(53,29);
            readln(del);
            if ((del='y') or (del='Y')) then
            begin
               ob[ketemu].kodeo:=ob[jo-1].kodeo;
               ob[ketemu].namao:=ob[jo-1].namao;
               ob[ketemu].hargao:=ob[jo-1].hargao;
               ob[ketemu].kat:=ob[jo-1].kat;
               ob[ketemu].des:=ob[jo-1].des;
               ob[jo-1].kodeo:='';
               ob[jo-1].namao:='';
               ob[jo-1].hargao:=0;
               ob[jo-1].kat:='';
               ob[jo-1].des:='';
               jo:=jo-1;
            end;
          end;
      end
      else if (((pil='t')or(pil='T'))and(view=false)) then
      begin
        gotoxy(1,29);clreol;write('Item ID : ');readln(id);
          ketemu:=0;
          for i := 1 to jo do
          begin
            if (ob[i].kodeo=id) then
              ketemu := i;
          end;
          if (ketemu = 0) then
          begin
             gotoxy(25,29);clreol;textcolor(red);write('Invalid Input');readln;
             textcolor(15);gotoxy(25,29);clreol;
          end
          else
          begin
            clrscr;
            writeln('+------------------------------------------------------------------------------+');
            gotoxy(1,4);write('|');gotoxy(80,8);write('|');
            gotoxy(80,2);write('|');gotoxy(80,9);write('|');
            gotoxy(80,3);write('|');gotoxy(80,4);write('|');
            gotoxy(80,5);write('|');
            gotoxy(80,6);write('|');
            gotoxy(80,7);write('|');
            gotoxy(1,2);writeln('|            ___       ________  ________  ________  ___  __');
            gotoxy(1,3);writeln('|           |\  \     |\   __  \|\   __  \|\   __  \|\  \|\  \');
            gotoxy(1,4);writeln('|           \ \  \    \ \  \|\  \ \  \|\  \ \  \|\  \ \  \/  /|_');
            gotoxy(1,5);writeln('|            \ \  \    \ \   __  \ \   ____\ \   __  \ \   ___  \');
            gotoxy(1,6);writeln('|             \ \  \____\ \  \ \  \ \  \___|\ \  \ \  \ \  \\ \  \');
            gotoxy(1,7);writeln('|              \ \_______\ \__\ \__\ \__\    \ \__\ \__\ \__\\ \__\');
            gotoxy(1,8);writeln('|               \|_______|\|__|\|__|\|__|     \|__|\|__|\|__| \|__|');
            gotoxy(1,9);writeln('|                 01001100  01000001  01010000  01000001  01001011');
            gotoxy(1,10);write('+------------+-------------+---------------+--------------------+--------------+');
            gotoxy(1,11);write('|   [H]OME   |  P[R]ODUCT  |    [O]RDER    |     [C]USTOMER     |   [S]EARCH   |');
            gotoxy(1,12);write('+------------+-------------+---------------+-----------------------------------+');
            gotoxy(1,13);write('| Item ID    |             | Item Name     |                                   |');       {deskripsi 42 karakter}
            gotoxy(1,14);write('+------------+-------------+---------------+--------------+-------+------------+');
            gotoxy(1,15);write('| Price      |             | Category      |              | Stock |            |');
            gotoxy(1,16);write('+------------+-------------+---------------+--------------+-------+------------+');
            gotoxy(1,17);write('| Deskripsi  |');
            gotoxy(1,18);write('+------------+');
            gotoxy(1,19);writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');
            write('+------------------------------------------------------------------------------+');
            gotoxy(1,29);write('New Stock : ');
            gotoxy(80,17);write('|');
            gotoxy(80,18);write('|');gotoxy(80,19);write('|');
            gotoxy(80,20);write('|');gotoxy(80,21);write('|');
            gotoxy(80,22);write('|');gotoxy(80,23);write('|');
            gotoxy(80,24);write('|');gotoxy(80,25);write('|');
            gotoxy(80,26);write('|');gotoxy(80,27);write('|');
            gotoxy(16,13);write(ob[ketemu].kodeo);
            gotoxy(46,13);write(ob[ketemu].namao);
            gotoxy(16,15);write('Rp ',ob[ketemu].hargao);
            gotoxy(46,15);write(ob[ketemu].kat);
            gotoxy(69,15);write(ob[ketemu].jmlho);
            gotoxy(3,19);
            pake := 0;
            kata := 0;
            butuh := 0;
            baris:=19;
            for i := 1 to length(ob[ketemu].des) do
            begin
                 j := i;
                 if (ob[ketemu].des[j]=' ') then
                 begin
                      butuh := 0;
                      j := j + 1 ;
                      pake := kata;
                      while (ob[ketemu].des[j]<>' ') do
                      begin
                           butuh := butuh + 1;
                           j := j + 1;
                      end;
                 end;
                 if (pake+butuh<76) then
                 begin
                      write(ob[ketemu].des[i]);
                      kata := kata + 1;
                 end
                 else
                 begin
                      baris:=baris+1;
                      gotoxy(2,baris);
                      write(ob[ketemu].des[i]);
                      kata := 1;
                      pake := 0;
                 end;
            end;
            gotoxy(13,29);
            readln(ob[ketemu].jmlho);
        end;
      end
      else if (((pil='e')or(pil='E'))and(view=false)) then
      begin
            gotoxy(1,29);clreol;write('Item ID : ');readln(id);
          ketemu:=0;
          for i := 1 to jo do
          begin
            if (ob[i].kodeo=id) then
              ketemu := i;
          end;
          if (ketemu = 0) then
          begin
             gotoxy(25,29);clreol;textcolor(red);write('Invalid Input');readln;
             textcolor(15);gotoxy(25,29);clreol;
          end
          else
          begin
            clrscr;
            writeln('+------------------------------------------------------------------------------+');
            gotoxy(1,4);write('|');gotoxy(80,8);write('|');
            gotoxy(80,2);write('|');gotoxy(80,9);write('|');
            gotoxy(80,3);write('|');gotoxy(80,4);write('|');
            gotoxy(80,5);write('|');
            gotoxy(80,6);write('|');
            gotoxy(80,7);write('|');
            gotoxy(1,2);writeln('|            ___       ________  ________  ________  ___  __');
            gotoxy(1,3);writeln('|           |\  \     |\   __  \|\   __  \|\   __  \|\  \|\  \');
            gotoxy(1,4);writeln('|           \ \  \    \ \  \|\  \ \  \|\  \ \  \|\  \ \  \/  /|_');
            gotoxy(1,5);writeln('|            \ \  \    \ \   __  \ \   ____\ \   __  \ \   ___  \');
            gotoxy(1,6);writeln('|             \ \  \____\ \  \ \  \ \  \___|\ \  \ \  \ \  \\ \  \');
            gotoxy(1,7);writeln('|              \ \_______\ \__\ \__\ \__\    \ \__\ \__\ \__\\ \__\');
            gotoxy(1,8);writeln('|               \|_______|\|__|\|__|\|__|     \|__|\|__|\|__| \|__|');
            gotoxy(1,9);writeln('|                 01001100  01000001  01010000  01000001  01001011');
            gotoxy(1,10);write('+------------+-------------+---------------+--------------------+--------------+');
            gotoxy(1,11);write('|   [H]OME   |  P[R]ODUCT  |    [O]RDER    |     [C]USTOMER     |   [S]EARCH   |');
            gotoxy(1,12);write('+------------+-------------+---------------+-----------------------------------+');
            gotoxy(1,13);write('| Item ID    |             | Item Name     |                                   |');       {deskripsi 42 karakter}
            gotoxy(1,14);write('+------------+-------------+---------------+--------------+-------+------------+');
            gotoxy(1,15);write('| Price      |             | Category      |              | Stock |            |');
            gotoxy(1,16);write('+------------+-------------+---------------+--------------+-------+------------+');
            gotoxy(1,17);write('| Deskripsi  |');
            gotoxy(1,18);write('+------------+');
            gotoxy(1,19);writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');
            write('+------------------------------------------------------------------------------+');
            gotoxy(80,17);write('|');
            gotoxy(80,18);write('|');gotoxy(80,19);write('|');
            gotoxy(80,20);write('|');gotoxy(80,21);write('|');
            gotoxy(80,22);write('|');gotoxy(80,23);write('|');
            gotoxy(80,24);write('|');gotoxy(80,25);write('|');
            gotoxy(80,26);write('|');gotoxy(80,27);write('|');
            gotoxy(16,13);write(ob[ketemu].kodeo);
            gotoxy(46,13);readln(ob[ketemu].namao);
            gotoxy(16,15);write('Rp ');
            gotoxy(19,15);readln(ob[ketemu].hargao);
            gotoxy(46,15);readln(ob[ketemu].kat);
            gotoxy(69,15);readln(ob[ketemu].jmlho);
            gotoxy(3,19);
            readln(ob[ketemu].des);
            gotoxy(28,29);write('PRESS [ENTER] TO CONTINUE');
            gotoxy(1,29);
            readln;
          end;
      end
      else if (((pil='i')or(pil='I'))and(view=false)) then
      begin
            clrscr;
            writeln('+------------------------------------------------------------------------------+');
            gotoxy(1,4);write('|');gotoxy(80,8);write('|');
            gotoxy(80,2);write('|');gotoxy(80,9);write('|');
            gotoxy(80,3);write('|');gotoxy(80,4);write('|');
            gotoxy(80,5);write('|');
            gotoxy(80,6);write('|');
            gotoxy(80,7);write('|');
            gotoxy(1,2);writeln('|            ___       ________  ________  ________  ___  __');
            gotoxy(1,3);writeln('|           |\  \     |\   __  \|\   __  \|\   __  \|\  \|\  \');
            gotoxy(1,4);writeln('|           \ \  \    \ \  \|\  \ \  \|\  \ \  \|\  \ \  \/  /|_');
            gotoxy(1,5);writeln('|            \ \  \    \ \   __  \ \   ____\ \   __  \ \   ___  \');
            gotoxy(1,6);writeln('|             \ \  \____\ \  \ \  \ \  \___|\ \  \ \  \ \  \\ \  \');
            gotoxy(1,7);writeln('|              \ \_______\ \__\ \__\ \__\    \ \__\ \__\ \__\\ \__\');
            gotoxy(1,8);writeln('|               \|_______|\|__|\|__|\|__|     \|__|\|__|\|__| \|__|');
            gotoxy(1,9);writeln('|                 01001100  01000001  01010000  01000001  01001011');
            gotoxy(1,10);write('+------------+-------------+---------------+--------------------+--------------+');
            gotoxy(1,11);write('|   [H]OME   |  P[R]ODUCT  |    [O]RDER    |     [C]USTOMER     |   [S]EARCH   |');
            gotoxy(1,12);write('+------------+-------------+---------------+-----------------------------------+');
            gotoxy(1,13);write('| Item ID    |             | Item Name     |                                   |');       {deskripsi 42 karakter}
            gotoxy(1,14);write('+------------+-------------+---------------+--------------+-------+------------+');
            gotoxy(1,15);write('| Price      | Rp          | Category      |              | Stock |            |');
            gotoxy(1,16);write('+------------+-------------+---------------+--------------+-------+------------+');
            gotoxy(1,17);write('| Deskripsi  |');
            gotoxy(1,18);write('+------------+');
            gotoxy(1,19);writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');
            write('+------------------------------------------------------------------------------+');
            gotoxy(80,17);write('|');
            gotoxy(80,18);write('|');gotoxy(80,19);write('|');
            gotoxy(80,20);write('|');gotoxy(80,21);write('|');
            gotoxy(80,22);write('|');gotoxy(80,23);write('|');
            gotoxy(80,24);write('|');gotoxy(80,25);write('|');
            gotoxy(80,26);write('|');gotoxy(80,27);write('|');
            gotoxy(16,13);readln(id);
            ketemu:=0;
            for i := 1 to jo do
            begin
                 if (ob[i].kodeo=id) then
                    ketemu := 1;
            end;
            if (ketemu = 1) then
            begin
                 gotoxy(3,19);textcolor(red);write('ID Already Registered');readln;
                 textcolor(15);
            end
            else
            begin
                 ob[jo].kodeo:=id;
                 gotoxy(46,13);readln(ob[jo].namao);
                 gotoxy(19,15);readln(ob[jo].hargao);
                 gotoxy(46,15);readln(ob[jo].kat);
                 gotoxy(69,15);readln(ob[jo].jmlho);
                 jo:=jo+1;
                 gotoxy(3,19);
                 readln(ob[jo].des);
                 gotoxy(28,29);write('PRESS [ENTER] TO CONTINUE');
                 gotoxy(1,29);
                 readln;
            end;
      end
      else if ((pil = 'n')or(pil='N')) then
      begin
        n := n + 13;
        if (n>jo) then
        begin
          gotoxy(25,29);clreol;textcolor(red);write('Invalid Input');readln;
          textcolor(15);gotoxy(25,29);clreol;
          n := n - 13;
        end;
      end
      else
      begin
        if ((pil = 'p')or(pil='P')) then
        begin
          n := n - 13;
          if (n < 0) then
          begin
            gotoxy(25,29);clreol;textcolor(red);write('Invalid Input');readln;
            textcolor(15);gotoxy(25,29);clreol;
            n := n + 13;
          end;
        end
        else if (((pil='h')or(pil='H'))and(view=false)) then
        begin
          k := 1;
          ganti := true;
        end
        else if (((pil='o')or(pil='O'))and(view=false)) then
        begin
          k := 3;
          ganti := true;
        end
        else if (((pil='c')or(pil='C'))and(view=false)) then
        begin
          k := 4;
          ganti := true;
        end
        else if (((pil='s')or(pil='S'))and(view=false)) then
        begin
          k := 5;
          ganti := true;
        end
        else if (view=true) then
        begin
          for i := 1 to jo do
          begin
            if (pil=ob[i].kodeo) then
              ketemu := i;
          end;
        end
        else
        begin
          gotoxy(25,29);clreol;textcolor(red);write('Invalid Input');readln;
          textcolor(15);gotoxy(25,29);clreol;
        end;
      end;
     until(ganti);
end;

Procedure customer(var ob : array of pembeli;var k,jo : integer);
{IS : menampilkan daftar customer
FS : admin dapat mengedit atau menghapus customer
Author : Mohammad Zakie Faiz Rahiemy}
  var
    pil,id : string;
    n,i,ketemu : integer;
    ganti,view:boolean;
    del:char;
  begin
    n := 1;
    view := false;
    repeat
      textcolor(15);
      ganti := false;
      k := 0;
      ketemu := 0;
      clrscr;
      gotoxy(1,1);writeln('+------------------------------------------------------------------------------+');
     gotoxy(1,2);writeln('|            ___       ________  ________  ________  ___  __                   |');
     gotoxy(1,3);writeln('|           |\  \     |\   __  \|\   __  \|\   __  \|\  \|\  \                 |');
     gotoxy(1,4);writeln('|           \ \  \    \ \  \|\  \ \  \|\  \ \  \|\  \ \  \/  /|_               |');
     gotoxy(1,5);writeln('|            \ \  \    \ \   __  \ \   ____\ \   __  \ \   ___  \              |');
     gotoxy(1,6);writeln('|             \ \  \____\ \  \ \  \ \  \___|\ \  \ \  \ \  \\ \  \             |');
     gotoxy(1,7);writeln('|              \ \_______\ \__\ \__\ \__\    \ \__\ \__\ \__\\ \__\            |');
     gotoxy(1,8);writeln('|               \|_______|\|__|\|__|\|__|     \|__|\|__|\|__| \|__|            |');
     gotoxy(1,9);writeln('|                 01001100  01000001  01010000  01000001  01001011             |');
     gotoxy(1,10);writeln('+------------+-------------+---------------+--------------------+--------------+');
     gotoxy(1,11);writeln('|   [H]OME   |  P[R]ODUCT  |    [O]RDER    |     [C]USTOMER     |   [S]EARCH   |');
     gotoxy(1,12);writeln('+--+---------+-----------------------+--------------------------+--------------+');
     gotoxy(1,13);writeln('|No|   id    |   Customer Name       |          Address         |   Telephone  |');
     gotoxy(1,14);writeln('+--+---------+-----------------------+--------------------------+--------------+');
     gotoxy(1,15);writeln('|                                                                              |');
     gotoxy(1,16);writeln('|                                                                              |');
     gotoxy(1,17);writeln('|                                                                              |');
     gotoxy(1,18);writeln('|                                                                              |');
     gotoxy(1,19);writeln('|                                                                              |');
     gotoxy(1,20);writeln('|                                                                              |');
     gotoxy(1,21);writeln('|                                                                              |');
     gotoxy(1,22);writeln('|                                                                              |');
     gotoxy(1,23);writeln('|                                                                              |');
     gotoxy(1,24);writeln('|                                                                              |');
     gotoxy(1,25);writeln('|                                                                              |');
     gotoxy(1,26);writeln('|                                                                              |');
     gotoxy(1,27);writeln('|                                                                              |');
     gotoxy(1,28);writeln('+------------------------------------------------------------------------------+');
     gotoxy(1,29);writeln('Select Menu : ');
      if ((jo-n) div 13 = 0) then
      begin
        for i := 1 to ((jo-n) mod 13) do
        begin
          gotoxy(1,i+14);write('|',i);gotoxy(4,i+14);write('| ',ob[i+n-1].idp);gotoxy(14,i+14);write('| ',ob[i+n-1].namap);
          gotoxy(38,i+14);write('| ',ob[i+n-1].alm);gotoxy(65,i+14);write('| ',ob[i+n-1].notelp);
          gotoxy(80,i+14);write('|');
        end;
        for i := ((jo-n) mod 13) to 13 do
        begin
          gotoxy(1,i+14);write('|');gotoxy(4,i+14);write('| ');gotoxy(14,i+14);write('| ');
          gotoxy(38,i+14);write('| ');gotoxy(65,i+14);write('|');
          gotoxy(80,i+14);write('|');
        end;
      end
      else
        for i := 1 to 13 do
        begin
          gotoxy(1,i+14);write('|',i);gotoxy(4,i+14);write('| ',ob[i+n-1].idp);gotoxy(14,i+14);write('| ',ob[i+n-1].namap);
          gotoxy(38,i+14);write('| ',ob[i+n-1].alm);gotoxy(65,i+14);write('|',ob[i+n-1].notelp);
          gotoxy(80,i+14);write('|');
        end;
      if (view=false) then
      begin
        gotoxy(1,30);write('[P]REV                         [E]DIT [D]ELETE                           [N]EXT');
        gotoxy(77,29);write((n div 13)+1,'/',(jo div 13)+1);
        gotoxy(1,29);write('Select Menu : ');readln(pil);
      end
      else
      begin
        gotoxy(1,30);write('[P]REV                         [E]DIT [D]ELETE                           [N]EXT');
        gotoxy(77,29);write((n div 13)+1,'/',(jo div 13)+1);
        gotoxy(1,29);write('Customer ID : ');readln(pil);
      end;
      if (((pil='d')or(pil='D'))and(view=false)) then
      begin
        gotoxy(1,29);clreol;write('Customer ID : ');readln(id);
          ketemu:=0;
          for i := 1 to jo do
          begin
            if (ob[i].idp=id) then
              ketemu := i;
          end;
          if (ketemu = 0) then
          begin
             gotoxy(25,29);clreol;textcolor(red);write('Invalid Input');readln;
             textcolor(15);gotoxy(25,29);clreol;
          end
          else
          begin
            clrscr;
            writeln('+------------------------------------------------------------------------------+');
            gotoxy(1,4);write('|');gotoxy(80,8);write('|');
            gotoxy(80,2);write('|');gotoxy(80,9);write('|');
            gotoxy(80,3);write('|');gotoxy(80,4);write('|');
            gotoxy(80,5);write('|');
            gotoxy(80,6);write('|');
            gotoxy(80,7);write('|');
            gotoxy(1,2);writeln('|            ___       ________  ________  ________  ___  __');
            gotoxy(1,3);writeln('|           |\  \     |\   __  \|\   __  \|\   __  \|\  \|\  \');
            gotoxy(1,4);writeln('|           \ \  \    \ \  \|\  \ \  \|\  \ \  \|\  \ \  \/  /|_');
            gotoxy(1,5);writeln('|            \ \  \    \ \   __  \ \   ____\ \   __  \ \   ___  \');
            gotoxy(1,6);writeln('|             \ \  \____\ \  \ \  \ \  \___|\ \  \ \  \ \  \\ \  \');
            gotoxy(1,7);writeln('|              \ \_______\ \__\ \__\ \__\    \ \__\ \__\ \__\\ \__\');
            gotoxy(1,8);writeln('|               \|_______|\|__|\|__|\|__|     \|__|\|__|\|__| \|__|');
            gotoxy(1,9);writeln('|                 01001100  01000001  01010000  01000001  01001011');
            gotoxy(1,10);write('+------------+-------------+---------------+--------------------+--------------+');
            gotoxy(1,11);write('|   [H]OME   |  P[R]ODUCT  |    [O]RDER    |     [C]USTOMER     |   [S]EARCH   |');
            gotoxy(1,12);write('+------------------------+-----------------------------------------------------+');
            gotoxy(1,13);write('| Customer ID            |                                                     |');       {deskripsi 42 karakter}
            gotoxy(1,14);write('+------------------------+-----------------------------------------------------+');
            gotoxy(1,15);write('| Customer Name          |                                                     |');
            gotoxy(1,16);write('+------------------------+-----------------------------------------------------+');
            gotoxy(1,17);write('| Address                |                                                     |');
            gotoxy(1,18);write('+------------------------+-----------------------------------------------------+');
            gotoxy(1,19);write('| Telephone              |                                                     |');
            gotoxy(1,20);write('+------------------------+-----------------------------------------------------+');
            gotoxy(1,21);writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');
            write('+------------------------------------------------------------------------------+');
            gotoxy(1,29);write('Are you really want to delete this product? (y/n) : ');
            gotoxy(80,21);write('|');
            gotoxy(80,22);write('|');gotoxy(80,23);write('|');
            gotoxy(80,24);write('|');gotoxy(80,25);write('|');
            gotoxy(80,26);write('|');gotoxy(80,27);write('|');
            gotoxy(28,13);write(ob[ketemu].idp);
            gotoxy(28,15);write(ob[ketemu].namap);
            gotoxy(28,17);write(ob[ketemu].alm);
            gotoxy(28,19);write(ob[ketemu].notelp);
            gotoxy(53,29);
            readln(del);
            if ((del='y') or (del='Y')) then
            begin
               ob[ketemu].idp:=ob[jo-1].idp;
               ob[ketemu].namap:=ob[jo-1].namap;
               ob[ketemu].alm:=ob[jo-1].alm;
               ob[ketemu].notelp:=ob[jo-1].notelp;
               ob[jo-1].idp:='';
               ob[jo-1].namap:='';
               ob[jo-1].alm:='';
               ob[jo-1].notelp:='';
               jo:=jo-1;
            end;
        end;
      end
      else if (((pil='e')or(pil='E'))and(view=false)) then
      begin
            gotoxy(1,29);clreol;write('Customer ID : ');readln(id);
          ketemu:=0;
          for i := 1 to jo do
          begin
            if (ob[i].idp=id) then
              ketemu := i;
          end;
          if (ketemu = 0) then
          begin
             gotoxy(25,29);clreol;textcolor(red);write('Invalid Input');readln;
             textcolor(15);gotoxy(25,29);clreol;
          end
          else
          begin
            clrscr;
            writeln('+------------------------------------------------------------------------------+');
            gotoxy(1,4);write('|');gotoxy(80,8);write('|');
            gotoxy(80,2);write('|');gotoxy(80,9);write('|');
            gotoxy(80,3);write('|');gotoxy(80,4);write('|');
            gotoxy(80,5);write('|');
            gotoxy(80,6);write('|');
            gotoxy(80,7);write('|');
            gotoxy(1,2);writeln('|            ___       ________  ________  ________  ___  __');
            gotoxy(1,3);writeln('|           |\  \     |\   __  \|\   __  \|\   __  \|\  \|\  \');
            gotoxy(1,4);writeln('|           \ \  \    \ \  \|\  \ \  \|\  \ \  \|\  \ \  \/  /|_');
            gotoxy(1,5);writeln('|            \ \  \    \ \   __  \ \   ____\ \   __  \ \   ___  \');
            gotoxy(1,6);writeln('|             \ \  \____\ \  \ \  \ \  \___|\ \  \ \  \ \  \\ \  \');
            gotoxy(1,7);writeln('|              \ \_______\ \__\ \__\ \__\    \ \__\ \__\ \__\\ \__\');
            gotoxy(1,8);writeln('|               \|_______|\|__|\|__|\|__|     \|__|\|__|\|__| \|__|');
            gotoxy(1,9);writeln('|                 01001100  01000001  01010000  01000001  01001011');
            gotoxy(1,10);write('+------------+-------------+---------------+--------------------+--------------+');
            gotoxy(1,11);write('|   [H]OME   |  P[R]ODUCT  |    [O]RDER    |     [C]USTOMER     |   [S]EARCH   |');
            gotoxy(1,12);write('+------------------------+-----------------------------------------------------+');
            gotoxy(1,13);write('| Customer ID            |                                                     |');       {deskripsi 42 karakter}
            gotoxy(1,14);write('+------------------------+-----------------------------------------------------+');
            gotoxy(1,15);write('| Customer Name          |                                                     |');
            gotoxy(1,16);write('+------------------------+-----------------------------------------------------+');
            gotoxy(1,17);write('| Address                |                                                     |');
            gotoxy(1,18);write('+------------------------+-----------------------------------------------------+');
            gotoxy(1,19);write('| Telephone              |                                                     |');
            gotoxy(1,20);write('+------------------------+-----------------------------------------------------+');
            gotoxy(1,21);writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');
            write('+------------------------------------------------------------------------------+');
            gotoxy(80,21);write('|');
            gotoxy(80,22);write('|');gotoxy(80,23);write('|');
            gotoxy(80,24);write('|');gotoxy(80,25);write('|');
            gotoxy(80,26);write('|');gotoxy(80,27);write('|');
            gotoxy(28,13);write(ob[ketemu].idp);
            gotoxy(28,15);readln(ob[ketemu].namap);
            gotoxy(28,17);readln(ob[ketemu].alm);
            gotoxy(28,19);readln(ob[ketemu].notelp);
            gotoxy(28,29);write('PRESS [ENTER] TO CONTINUE');
            gotoxy(1,29);
            readln;
          end;
      end
      else if ((pil = 'n')or(pil='N')) then
      begin
        n := n + 13;
        if (n>jo) then
        begin
          gotoxy(25,29);clreol;textcolor(red);write('Invalid Input');readln;
          textcolor(15);gotoxy(25,29);clreol;
          n := n - 13;
        end;
      end
      else
      begin
        if ((pil = 'p')or(pil='P')) then
        begin
          n := n - 13;
          if (n < 0) then
          begin
            gotoxy(25,29);clreol;textcolor(red);write('Invalid Input');readln;
            textcolor(15);gotoxy(25,29);clreol;
            n := n + 13;
          end;
        end
        else if (((pil='h')or(pil='H'))and(view=false)) then
        begin
          k := 1;
          ganti := true;
        end
        else if (((pil='o')or(pil='O'))and(view=false)) then
        begin
          k := 3;
          ganti := true;
        end
        else if (((pil='r')or(pil='R'))and(view=false)) then
        begin
          k := 2;
          ganti := true;
        end
        else if (((pil='s')or(pil='S'))and(view=false)) then
        begin
          k := 5;
          ganti := true;
        end
        else if (view=true) then
        begin
          for i := 1 to jo do
          begin
            if (pil=ob[i].idp) then
              ketemu := i;
          end;
        end
        else
        begin
          gotoxy(25,29);clreol;textcolor(red);write('Invalid Input');readln;
          textcolor(15);gotoxy(25,29);clreol;
        end;
      end;
     until(ganti);
end;


  procedure order(var st : array of struk; js:integer; var k : integer);
  var
    baris,i,j,k1,l,n0,n1,cari,cari2,pil2 : integer;
    hal : array [1..10] of integer;
    pil : string;
    ganti,no,edit : boolean;
  begin
    ganti := false;
    edit := false;
    i := 1;
    n0 := 0;
    l := 1;
    repeat
      n1 := i;
      baris := 1;
      textcolor(15);
      clrscr;
      writeln('+------------------------------------------------------------------------------+');
      gotoxy(1,4);write('|');gotoxy(80,8);write('|');
      gotoxy(80,2);write('|');gotoxy(80,9);write('|');
      gotoxy(80,3);write('|');
      gotoxy(80,4);write('|');
      gotoxy(80,5);write('|');
      gotoxy(80,6);write('|');
      gotoxy(80,7);write('|');
      gotoxy(1,2);writeln('|            ___       ________  ________  ________  ___  __');
      gotoxy(1,3);writeln('|           |\  \     |\   __  \|\   __  \|\   __  \|\  \|\  \');
      gotoxy(1,4);writeln('|           \ \  \    \ \  \|\  \ \  \|\  \ \  \|\  \ \  \/  /|_');
      gotoxy(1,5);writeln('|            \ \  \    \ \   __  \ \   ____\ \   __  \ \   ___  \');
      gotoxy(1,6);writeln('|             \ \  \____\ \  \ \  \ \  \___|\ \  \ \  \ \  \\ \  \');
      gotoxy(1,7);writeln('|              \ \_______\ \__\ \__\ \__\    \ \__\ \__\ \__\\ \__\');
      gotoxy(1,8);writeln('|               \|_______|\|__|\|__|\|__|     \|__|\|__|\|__| \|__|');
      gotoxy(1,9);writeln('|                 01001100  01000001  01010000  01000001  01001011');
      gotoxy(1,10);write('+------------+-------------+---------------+--------------------+--------------+');
      gotoxy(1,11);write('|   [H]OME   |  P[R]ODUCT  |    [O]RDER    |     [C]USTOMER     |   [S]EARCH   |');
      gotoxy(1,12);write('+----+-------+---+-------+-+----+---------++---------------+----+--------------+');
      gotoxy(1,13);write('| No |Customer ID|Item ID|Amount|  Price  |      Total     |       Status      |');
      gotoxy(1,14);write('+----+-----------+-------+------+---------+----------------+-------------------+');
      gotoxy(1,28);write('+----+-----------+-------+------+---------+----------------+-------------------+');
      while ((baris+st[i].jum<14)and(i<js)) do
      begin
        gotoxy(1,14+baris);write('| ',i);
        gotoxy(6,14+baris);write('| ',st[i].id);
        gotoxy(18,14+baris);write('| ',st[i].be[1].kodeb);
        gotoxy(26,14+baris);write('| ',st[i].be[1].jmlhb);
        gotoxy(33,14+baris);write('|Rp.',st[i].be[1].hargab);
        gotoxy(43,14+baris);write('| ');
        gotoxy(60,14+baris);write('| ');
        gotoxy(80,14+baris);write('|');
        if (st[i].jum>1) then
        begin
          for j := 2 to st[i].jum do
          begin
            baris := baris+1;
            gotoxy(1,14+baris);write('| ');
            gotoxy(6,14+baris);write('| ');
            gotoxy(18,14+baris);write('| ',st[i].be[j].kodeb);
            gotoxy(26,14+baris);write('| ',st[i].be[j].jmlhb);
            gotoxy(33,14+baris);write('|Rp.',st[i].be[j].hargab);
            gotoxy(43,14+baris);write('| ');
            gotoxy(60,14+baris);write('| ');
            gotoxy(80,14+baris);write('|');
          end;
          gotoxy(43,14+baris);write('|Rp.',st[i].total:0:1);
          gotoxy(60,14+baris);write('|',st[i].stat);
          baris := baris+1;
        end
        else
        begin
          gotoxy(43,14+baris);write('|Rp.',st[i].total:0:1);
          gotoxy(60,14+baris);write('|',st[i].stat);
          baris := baris+1;
        end;
        i := i+1;
      end;
      if (baris<14) then
      begin
        for j := baris to 13 do
        begin
          gotoxy(1,14+baris);write('| ');
            gotoxy(6,14+baris);write('| ');
            gotoxy(18,14+baris);write('| ');
            gotoxy(26,14+baris);write('| ');
            gotoxy(33,14+baris);write('|');
            gotoxy(43,14+baris);write('| ');
            gotoxy(60,14+baris);write('| ');
            gotoxy(80,14+baris);write('|');
          baris := baris +1;
        end;
      end;
      no := false;
      if (l>1) then
        for j := 1 to l do
          if (n1=hal[j]) then
            no := true;
      if (no=false) then
      begin
        hal[l] := n1;
        l := l+1;
      end;
      if (edit=false) then
      begin
        gotoxy(1,30);write('[P]REV                       [E]DIT STATUS                               [N]EXT');
        gotoxy(1,29);write('Select Menu : ');readln(pil);
      end
      else
      begin
        gotoxy(1,29);write('Order No : ');readln(cari);
        cari2 := 0;
        for j := 1 to js-1 do
        begin
          if (cari=j) then
          begin
            cari2 := j;
          end;
        end;
        if (cari2=0) then
        begin
          gotoxy(25,29);textcolor(red);write('Invalid Input');readln;
          textcolor(15);gotoxy(1,29);clreol;
        end
        else
        begin
          gotoxy(1,29);clreol;
          gotoxy(1,30);write('[1]Awaiting Payment [2]Payment Received [3]Shipped [4]Delivered [5]Canceled');
          gotoxy(1,29);write('Status : ');readln(pil2);
          while ((pil2<>1)and(pil2<>2)and(pil2<>3)and(pil2<>4)and(pil2<>5)) do
          begin
            gotoxy(25,29);textcolor(red);write('Invalid Input');readln;
            textcolor(15);gotoxy(1,29);clreol;write('Status : ');readln(pil2);
          end;
          case (pil2) of
            1 : st[cari2].stat := 'Awaiting Payment';
            2 : st[cari2].stat := 'Payment Received';
            3 : st[cari2].stat := 'Shipped';
            4 : st[cari2].stat := 'Delivered';
            5 : st[cari2].stat := 'Canceled';
          end;
          pil := 'f';
        end;
      end;
      if (((pil = 'n')or(pil='N'))and(edit=false)) then
      begin
        if (i=js) then
        begin
          gotoxy(25,29);textcolor(red);write('Invalid Input');readln;
          textcolor(15);gotoxy(25,29);clreol;
          i := n1;
        end
        else
          n0 := 1;
      end
      else if (((pil = 'p')or(pil='P'))and(edit=false)) then
      begin
        if (n0 = 0) then
        begin
          gotoxy(25,29);textcolor(red);write('Invalid Input');readln;
          textcolor(15);gotoxy(25,29);clreol;
          i := n1;
        end
        else
        begin
          if (n1=hal[2]) then
          begin
            i := hal[1];
            n0 := 0;
          end
          else
          begin
            for k1 := 1 to l do
            begin
              if (hal[k1]=n1) then
                i := hal[k1-1];
                n0 := 1;
            end;
          end;
        end;
      end
      else if (((pil='e')or(pil='E'))and(edit=false)) then
      begin
        edit := true;
        i := n1;
      end
      else if (((pil='h')or(pil='H'))and(edit=false)) then
      begin
        k := 1;
        ganti := true;
      end
      else if (((pil='c')or(pil='C'))and(edit=false)) then
      begin
        k := 4;
        ganti := true;
      end
      else if (((pil='r')or(pil='R'))and(edit=false)) then
      begin
        k := 2;
        ganti := true;
      end
      else if (((pil='s')or(pil='S'))and(edit=false)) then
      begin
        k := 5;
        ganti := true;
      end
      else if (((pil='f')or(pil='F'))and(edit)) then
      begin
        edit := false;
        i := n1;
      end
      else
      begin
        gotoxy(25,29);textcolor(red);write('Invalid Input');readln;
        textcolor(15);gotoxy(25,29);clreol;
        i := n1;
      end;
    until(ganti);
  end;


  procedure search(ob : array of barang; st : array of struk; pe : array of pembeli; jo,js,jp : integer;var k : integer);
  {IS : pengguna memilih sebuah menu pilihan yang tersedia dan memasukkan sebuah kata kunci yang akan dicari
   FS : menampilkan daftar data sesuai kata kunci yang telah dimasukkan
   Author : Ubassy Abdillah}
  var
    baris,i,j,k1,l,n,n0,n1,jm,ketemunam : integer;
    hal : array [1..10] of integer;
    ketemu : array [1..50] of integer;
    pil,cari2,carinam,pil2 : string;
    ganti,caris,carip,caric,no : boolean;
  begin
    ganti := false;
    caris:=false;
    carip:=false;
    caric:=false;
    pil2 := 'nill';
    i := 1;
    n := 1;
    n0 := 0;
    l := 1;
    jm := 0;
    for j := 1 to 10 do
      hal[j] := 0;
    for j := 1 to 50 do
      ketemu[j] := 0;
    repeat
      baris := 1;
      textcolor(15);
      clrscr;
      writeln('+------------------------------------------------------------------------------+');
      gotoxy(1,4);write('|');gotoxy(80,8);write('|');
      gotoxy(80,2);write('|');gotoxy(80,9);write('|');
      gotoxy(80,3);write('|');
      gotoxy(80,4);write('|');
      gotoxy(80,5);write('|');
      gotoxy(80,6);write('|');
      gotoxy(80,7);write('|');
      gotoxy(1,2);writeln('|            ___       ________  ________  ________  ___  __');
      gotoxy(1,3);writeln('|           |\  \     |\   __  \|\   __  \|\   __  \|\  \|\  \');
      gotoxy(1,4);writeln('|           \ \  \    \ \  \|\  \ \  \|\  \ \  \|\  \ \  \/  /|_');
      gotoxy(1,5);writeln('|            \ \  \    \ \   __  \ \   ____\ \   __  \ \   ___  \');
      gotoxy(1,6);writeln('|             \ \  \____\ \  \ \  \ \  \___|\ \  \ \  \ \  \\ \  \');
      gotoxy(1,7);writeln('|              \ \_______\ \__\ \__\ \__\    \ \__\ \__\ \__\\ \__\');
      gotoxy(1,8);writeln('|               \|_______|\|__|\|__|\|__|     \|__|\|__|\|__| \|__|');
      gotoxy(1,9);writeln('|                 01001100  01000001  01010000  01000001  01001011');
      gotoxy(1,10);writeln('+------------+-------------+---------------+--------------------+--------------+');
      gotoxy(1,11);writeln('|   [H]OME   |  P[R]ODUCT  |    [O]RDER    |     [C]USTOMER     |   [S]EARCH   |');
      if ((caris=false)and(carip=false)and(caric=false)) then
      begin
        gotoxy(1,12);writeln('+------------+-------------+---------------+--------------------+--------------+');
        gotoxy(1,13);writeln('|                                                                              |');
        gotoxy(1,14);writeln('|                                                                              |');
        gotoxy(1,15);writeln('|                                                                              |');
        gotoxy(1,16);writeln('|                                                                              |');
        gotoxy(1,17);writeln('|                      SEARCH BY OR[D]ER                                       |');
        gotoxy(1,18);writeln('|                                                                              |');
        gotoxy(1,19);writeln('|                      SEARCH BY C[U]STOMER                                    |');
        gotoxy(1,20);writeln('|                                                                              |');
        gotoxy(1,21);writeln('|                      SEARCH BY [P]RODUCT                                     |');
        gotoxy(1,22);writeln('|                                                                              |');
        gotoxy(1,23);writeln('|                                                                              |');
        gotoxy(1,24);writeln('|                                                                              |');
        gotoxy(1,25);writeln('|                                                                              |');
        gotoxy(1,26);writeln('|                                                                              |');
        gotoxy(1,27);writeln('|                                                                              |');
        gotoxy(1,28);writeln('+------------------------------------------------------------------------------+');
        gotoxy(1,29);write('Select Menu : ');readln(pil);
      end
      else if (caris) then
      begin
        gotoxy(1,12);write('+----+-------+---+-------+-+---------------+-+------+---------+-+--------------+');
        gotoxy(1,13);write('| No |Customer ID|Item ID|     Item Name     |Amount|  Price  |      Total     |');
        gotoxy(1,14);write('+----+-----------+-------+-------------------+------+---------+----------------+');
        gotoxy(1,28);write('+----+-----------+-------+-------------------+------+---------+----------------+');
        n1 := i;
        while ((baris+st[ketemu[i]].jum<15)and(i<=jm)) do
        begin
          gotoxy(1,14+baris);write('| ',ketemu[i]);gotoxy(6,14+baris);write('| ',st[ketemu[i]].id);gotoxy(18,14+baris);write('| ',st[ketemu[i]].be[1].kodeb);
          gotoxy(26,14+baris);write('| ',st[ketemu[i]].be[1].namab);gotoxy(46,14+baris);write('| ',st[ketemu[i]].be[1].jmlhb);gotoxy(53,14+baris);write('|Rp.',st[ketemu[i]].be[1].hargab);
          gotoxy(80,14+baris);write('|');
          gotoxy(63,14+baris);write('| ');
          if (st[ketemu[i]].jum>1) then
          begin
            for j := 2 to st[ketemu[i]].jum do
            begin
              baris := baris+1;
              gotoxy(1,14+baris);write('| ');
              gotoxy(6,14+baris);write('| ');
              gotoxy(18,14+baris);write('| ',st[ketemu[i]].be[j].kodeb);
              gotoxy(26,14+baris);write('| ',st[ketemu[i]].be[j].namab);
              gotoxy(46,14+baris);write('| ',st[ketemu[i]].be[j].jmlhb);
              gotoxy(53,14+baris);write('|Rp.',st[ketemu[i]].be[j].hargab);
              gotoxy(80,14+baris);write('|');
              gotoxy(63,14+baris);write('| ');
            end;
            gotoxy(63,14+baris);write('|Rp.',st[ketemu[i]].total:0:1);
            baris := baris+1;
          end
          else
          begin
            gotoxy(63,14+baris);write('|Rp.',st[ketemu[i]].total:0:1);
            baris := baris+1;
          end;
          i := i+1;
        end;
        if (baris<14) then
        begin
          for j := baris to 13 do
          begin
            gotoxy(1,14+baris);write('| ');
              gotoxy(6,14+baris);write('| ');
              gotoxy(18,14+baris);write('| ');
              gotoxy(26,14+baris);write('| ');
              gotoxy(46,14+baris);write('| ');
              gotoxy(53,14+baris);write('|');
              gotoxy(80,14+baris);write('|');
              gotoxy(63,14+baris);write('| ');
            baris := baris +1;
          end;
        end;
        no := false;
        if (l>1) then
          for j := 1 to l do
            if (n1=hal[j]) then
              no := true;
        if (no=false) then
        begin
          hal[l] := n1;
          l := l+1;
        end;
        gotoxy(1,30);write('[P]REV                          [F]INISH                                 [N]EXT');
        gotoxy(1,29);write('Select Menu : ');readln(pil);
      end
      else if ((caric)and((pil='a')or(pil='A'))) then
      begin
        ketemunam := 0;
        gotoxy(1,12);write('+-----------++-------------+-----+---------+--------------------+--------------+');
        gotoxy(1,13);write('|Customer ID|    Customer Name   |       Customer Address       | Phone Number |');
        gotoxy(1,14);write('+-----------+--------------------+------------------------------+--------------+');
        for j := 1 to 13 do
        begin
          gotoxy(1,14+j);write('|');
          gotoxy(13,14+j);write('|');
          gotoxy(34,14+j);write('|');
          gotoxy(65,14+j);write('|');
          gotoxy(80,14+j);write('|');
        end;
        gotoxy(1,28);write('+-----------+--------------------+------------------------------+--------------+');
        gotoxy(1,29);write('Customer Name : ');readln(carinam);
        for j := 1 to jp-1 do
        begin
          if (pe[j].namap=carinam) then
            ketemunam := j;
        end;
        if (ketemunam = 0) then
        begin
          gotoxy(25,29);textcolor(red);write('Invalid Input');readln;
          textcolor(15);gotoxy(25,29);clreol;
        end
        else
        begin
          gotoxy(1,10);write('+------------+-------------+---------------+--------------------+--------------+');
          gotoxy(1,11);write('|   [H]OME   |  P[R]ODUCT  |    [O]RDER    |     [C]USTOMER     |   [S]EARCH   |');
          gotoxy(1,12);write('+-----------++-------------+-----+---------+--------------------+--------------+');
          gotoxy(1,13);write('|Customer ID|    Customer Name   |       Customer Address       | Phone Number |');
          gotoxy(1,14);write('+-----------+--------------------+------------------------------+--------------+');
          for j := 1 to 12 do
          begin
            gotoxy(1,15+j);write('|');
            gotoxy(13,15+j);write('|');
            gotoxy(34,15+j);write('|');
            gotoxy(65,15+j);write('|');
            gotoxy(80,15+j);write('|');
          end;
          gotoxy(1,28);write('+-----------+--------------------+------------------------------+--------------+');
          gotoxy(1,15);write('|',pe[ketemunam].idp);
          gotoxy(13,15);write('|',pe[ketemunam].namap);
          gotoxy(34,15);write('|');
          if (length(pe[ketemunam].alm)>30) then
          begin
            for j := 1 to 27 do
              write(pe[ketemunam].alm[j]);
            write('...')
          end
          else
            write(pe[ketemunam].alm);
          gotoxy(65,15);write('|',pe[ketemunam].notelp);
          gotoxy(80,15);write('|');
          gotoxy(1,30);write('                                [F]INISH                                       ');
          gotoxy(1,29);clreol;
          gotoxy(1,29);write('Select Menu : ');readln(pil);
          while ((pil<>'f')and(pil<>'F')) do
          begin
            gotoxy(25,29);textcolor(red);write('Invalid Input');readln;
            textcolor(15);gotoxy(15,29);clreol;readln(pil);
          end;
        end;
      end
      else if ((caric)and((pil='i')or(pil='I'))) then
      begin
        ketemunam := 0;
        gotoxy(1,12);write('+-----------++-------------+-----+---------+--------------------+--------------+');
        gotoxy(1,13);write('|Customer ID|    Customer Name   |       Customer Address       | Phone Number |');
        gotoxy(1,14);write('+-----------+--------------------+------------------------------+--------------+');
        for j := 1 to 13 do
        begin
          gotoxy(1,14+j);write('|');
          gotoxy(13,14+j);write('|');
          gotoxy(34,14+j);write('|');
          gotoxy(65,14+j);write('|');
          gotoxy(80,14+j);write('|');
        end;
        gotoxy(1,28);write('+-----------+--------------------+------------------------------+--------------+');
        gotoxy(1,29);write('Customer ID : ');readln(carinam);
        for j := 1 to jp-1 do
        begin
          if (pe[j].idp=carinam) then
            ketemunam := j;
        end;
        if (ketemunam = 0) then
        begin
          gotoxy(25,29);textcolor(red);write('Invalid Input');readln;
          textcolor(15);gotoxy(25,29);clreol;
        end
        else
        begin
          gotoxy(1,12);write('+-----------++-------------+-----+---------+--------------------+--------------+');
          gotoxy(1,13);write('|Customer ID|    Customer Name   |       Customer Address       | Phone Number |');
          gotoxy(1,14);write('+-----------+--------------------+------------------------------+--------------+');
          for j := 1 to 12 do
          begin
            gotoxy(1,15+j);write('|');
            gotoxy(13,15+j);write('|');
            gotoxy(34,15+j);write('|');
            gotoxy(65,15+j);write('|');
            gotoxy(80,15+j);write('|');
          end;
          gotoxy(1,28);write('+-----------+--------------------+------------------------------+--------------+');
          gotoxy(1,15);write('|',pe[ketemunam].idp);
          gotoxy(13,15);write('|',pe[ketemunam].namap);
          gotoxy(34,15);write('|');
          if (length(pe[ketemunam].alm)>30) then
          begin
            for j := 1 to 27 do
              write(pe[ketemunam].alm[j]);
            write('...')
          end
          else
            write(pe[ketemunam].alm);
          gotoxy(65,15);write('|',pe[ketemunam].notelp);
          gotoxy(80,15);write('|');
          gotoxy(1,30);write('                                [F]INISH                                       ');
          gotoxy(1,29);clreol;
          gotoxy(1,29);write('Select Menu : ');readln(pil);
          while ((pil<>'f')and(pil<>'F')) do
          begin
            gotoxy(25,29);textcolor(red);write('Invalid Input');readln;
            textcolor(15);gotoxy(15,29);clreol;readln(pil);
          end;
        end;
      end
      else if ((carip)and((pil2='i')or(pil2='I'))) then
      begin
        ketemunam := 0;
        gotoxy(1,12);write('+--+--------++-------------+---------+-----+-+-------------+----+--------------+');
        gotoxy(1,13);write('|No|  id    |       Item Name        | Stock |    Price    |      Category     |');
        gotoxy(1,14);write('+--+--------+------------------------+-------+-------------+-------------------+');
        for j := 1 to 13 do
          begin
            gotoxy(1,14+j);write('|');
            gotoxy(4,14+j);write('|');
            gotoxy(13,14+j);write('|');
            gotoxy(38,14+j);write('|');
            gotoxy(46,14+j);write('|');
            gotoxy(60,14+j);write('|');
            gotoxy(80,14+j);write('|');
          end;
        write('+--+--------+------------------------+-------+-------------+-------------------+');
        gotoxy(1,29);write('Item ID : ');readln(carinam);
        for j := 1 to jo-1 do
        begin
          if (ob[j].kodeo=carinam) then
            ketemunam := j;
        end;
        if (ketemunam = 0) then
        begin
          gotoxy(25,29);textcolor(red);write('Invalid Input');readln;
          textcolor(15);gotoxy(25,29);clreol;
        end
        else
        begin
          gotoxy(1,12);write('+--+--------++-------------+---------+-----+-+-------------+----+--------------+');
          gotoxy(1,13);write('|No|  id    |       Item Name        | Stock |    Price    |      Category     |');
          gotoxy(1,14);write('+--+--------+------------------------+-------+-------------+-------------------+');
          for j := 1 to 12 do
          begin
            gotoxy(1,15+j);write('|');
            gotoxy(4,15+j);write('|');
            gotoxy(13,15+j);write('|');
            gotoxy(38,15+j);write('|');
            gotoxy(46,15+j);write('|');
            gotoxy(60,15+j);write('|');
            gotoxy(80,15+j);write('|');
          end;
          gotoxy(1,28);write('+--+--------+------------------------+-------+-------------+-------------------+');
          gotoxy(1,15);write('|',1);
          gotoxy(4,15);write('|',ob[ketemunam].kodeo);
          gotoxy(13,15);write('|',ob[ketemunam].namao);
          gotoxy(38,15);write('|',ob[ketemunam].jmlho);
          gotoxy(46,15);write('|',ob[ketemunam].hargao);
          gotoxy(60,15);write('|',ob[ketemunam].kat);
          gotoxy(80,15);write('|');
          gotoxy(1,30);write('                                [F]INISH                                       ');
          gotoxy(1,29);clreol;
          gotoxy(1,29);write('Select Menu : ');readln(pil);
          while ((pil<>'f')and(pil<>'F')) do
          begin
            gotoxy(25,29);textcolor(red);write('Invalid Input');readln;
            textcolor(15);gotoxy(15,29);clreol;readln(pil);
          end;
        end;
      end
      else if ((carip)and((pil2='a')or(pil2='A'))) then
      begin
        ketemunam := 0;
        gotoxy(1,12);write('+--+--------++-------------+---------+-----+-+-------------+----+--------------+');
        gotoxy(1,13);write('|No|  id    |       Item Name        | Stock |    Price    |      Category     |');
        gotoxy(1,14);write('+--+--------+------------------------+-------+-------------+-------------------+');
        for j := 1 to 13 do
          begin
            gotoxy(1,14+j);write('|');
            gotoxy(4,14+j);write('|');
            gotoxy(13,14+j);write('|');
            gotoxy(38,14+j);write('|');
            gotoxy(46,14+j);write('|');
            gotoxy(60,14+j);write('|');
            gotoxy(80,14+j);write('|');
          end;
        write('+--+--------+------------------------+-------+-------------+-------------------+');
        gotoxy(1,29);write('Item Name : ');readln(carinam);
        for j := 1 to jo-1 do
        begin
          if (ob[j].namao=carinam) then
            ketemunam := j;
        end;
        if (ketemunam = 0) then
        begin
          gotoxy(25,29);textcolor(red);write('Invalid Input');readln;
          textcolor(15);gotoxy(25,29);clreol;
        end
        else
        begin
          gotoxy(1,12);write('+--+--------++-------------+---------+-----+-+-------------+----+--------------+');
          gotoxy(1,13);write('|No|  id    |       Item Name        | Stock |    Price    |      Category     |');
          gotoxy(1,14);write('+--+--------+------------------------+-------+-------------+-------------------+');
          for j := 1 to 12 do
          begin
            gotoxy(1,15+j);write('|');
            gotoxy(4,15+j);write('|');
            gotoxy(13,15+j);write('|');
            gotoxy(38,15+j);write('|');
            gotoxy(46,15+j);write('|');
            gotoxy(60,15+j);write('|');
            gotoxy(80,15+j);write('|');
          end;
          gotoxy(1,28);write('+--+--------+------------------------+-------+-------------+-------------------+');
          gotoxy(1,15);write('|',1);
          gotoxy(4,15);write('|',ob[ketemunam].kodeo);
          gotoxy(13,15);write('|',ob[ketemunam].namao);
          gotoxy(38,15);write('|',ob[ketemunam].jmlho);
          gotoxy(46,15);write('|',ob[ketemunam].hargao);
          gotoxy(60,15);write('|',ob[ketemunam].kat);
          gotoxy(80,15);write('|');
          gotoxy(1,30);write('                                [F]INISH                                       ');
          gotoxy(1,29);clreol;
          gotoxy(1,29);write('Select Menu : ');readln(pil);
          while ((pil<>'f')and(pil<>'F')) do
          begin
            gotoxy(25,29);textcolor(red);write('Invalid Input');readln;
            textcolor(15);gotoxy(15,29);clreol;readln(pil);
          end;
        end;
      end
      else if ((carip)and((pil2='c')or(pil2='C'))) then
      begin
        ketemunam := 0;
        gotoxy(1,12);write('+--+--------++-------------+---------+-----+-+-------------+----+--------------+');
        gotoxy(1,13);write('|No|  id    |       Item Name        | Stock |    Price    |      Category     |');
        gotoxy(1,14);write('+--+--------+------------------------+-------+-------------+-------------------+');
        for j := 1 to 13 do
          begin
            gotoxy(1,14+j);write('|');
            gotoxy(4,14+j);write('|');
            gotoxy(13,14+j);write('|');
            gotoxy(38,14+j);write('|');
            gotoxy(46,14+j);write('|');
            gotoxy(60,14+j);write('|');
            gotoxy(80,14+j);write('|');
          end;
        write('+--+--------+------------------------+-------+-------------+-------------------+');
        gotoxy(1,29);write('Item Category : ');readln(carinam);
        jm := 0;
        for j := 1 to jo-1 do
          if (carinam=ob[j].kat) then
          begin
            jm := jm +1;
            ketemu[jm] := j;
          end;
        if (jm = 0) then
        begin
          gotoxy(25,29);textcolor(red);write('Invalid Input');readln;
          textcolor(15);gotoxy(25,29);clreol;
        end
        else
        begin
          gotoxy(1,12);write('+--+--------++-------------+---------+-----+-+-------------+----+--------------+');
          gotoxy(1,13);write('|No|  id    |       Item Name        | Stock |    Price    |      Category     |');
          gotoxy(1,14);write('+--+--------+------------------------+-------+-------------+-------------------+');
          if ((jm-n) div 13 = 0) then
          begin
            for j := 1 to ((jm-n) mod 13) do
            begin
              gotoxy(1,j+14);write('|',j);gotoxy(4,j+14);write('| ',ob[ketemu[j]+n-1].kodeo);gotoxy(13,j+14);write('| ',ob[ketemu[j]+n-1].namao);
              gotoxy(38,j+14);write('| ',ob[ketemu[j]+n-1].jmlho);gotoxy(46,j+14);write('| Rp. ',ob[ketemu[j]+n-1].hargao);
              gotoxy(60,j+14);write('| ',ob[ketemu[j]+n-1].kat);gotoxy(80,j+14);write('|');
            end;
            for j := ((jm-n) mod 13) to 13 do
            begin
              gotoxy(1,j+14);write('|');gotoxy(4,j+14);write('|');gotoxy(13,j+14);write('|');
              gotoxy(38,j+14);write('|');gotoxy(46,j+14);write('|');gotoxy(60,j+14);write('|');
              gotoxy(80,j+14);write('|');
            end;
          end
          else
            for j := 1 to 13 do
            begin
              gotoxy(1,j+14);write('|',j);gotoxy(4,j+14);write('| ',ob[ketemu[j]+n-1].kodeo);gotoxy(13,j+14);write('| ',ob[ketemu[j]+n-1].namao);
              gotoxy(38,j+14);write('| ',ob[ketemu[j]+n-1].jmlho);gotoxy(46,j+14);write('| Rp. ',ob[ketemu[j]+n-1].hargao);
              gotoxy(60,j+14);write('| ',ob[ketemu[j]+n-1].kat);gotoxy(80,j+14);write('|');
            end;
          gotoxy(1,30);write('                                [F]INISH                                       ');
          gotoxy(1,29);clreol;
          gotoxy(1,29);write('Select Menu : ');readln(pil);
          while ((pil<>'f')and(pil<>'F')) do
          begin
            gotoxy(25,29);textcolor(red);write('Invalid Input');readln;
            textcolor(15);gotoxy(15,29);clreol;readln(pil);
          end;
        end;
      end;

      if (((pil = 'n')or(pil='N'))and(caris)) then
      begin
        if (i>jm) then
        begin
          gotoxy(25,29);textcolor(red);write('Invalid Input');readln;
          textcolor(15);gotoxy(25,29);clreol;
          i := n1;
        end
        else
          n0 := 1;
      end
      else if (((pil = 'p')or(pil='P'))and(caris)) then
      begin
        if (n0 = 0) then
        begin
          gotoxy(25,29);textcolor(red);write('Invalid Input');readln;
          textcolor(15);gotoxy(25,29);clreol;
          i := n1;
        end
        else
        begin
          if (n1=hal[2]) then
          begin
            i := hal[1];
            n0 := 0;
          end
          else
          begin
            for k1 := 1 to l do
            begin
              if (hal[k1]=n1) then
                i := hal[k1-1];
                n0 := 1;
            end;
          end;
        end;
      end
      else if (((pil = 'n')or(pil='N'))and((carip)and((pil2='c')or(pil2='C')))) then
      begin
        n := n + 13;
        if (n>jo) then
        begin
          gotoxy(25,29);textcolor(red);write('Invalid Input');readln;
          textcolor(15);gotoxy(25,29);clreol;
          gotoxy(77,29);write((n div 13)+1,'/',(jo div 13)+1);
          n := n - 13;
        end;
      end
      else if (((pil = 'p')or(pil='P'))and((carip)and((pil2='c')or(pil2='C')))) then
      begin
        n := n - 13;
        if (n < 0) then
        begin
          gotoxy(25,29);textcolor(red);write('Invalid Input');readln;
          textcolor(15);gotoxy(25,29);clreol;
          n := n + 13;
        end;
      end
      else if (((pil='h')or(pil='H'))and((caris=false)and(carip=false)and(caric=false))) then
      begin
        k := 1;
        ganti := true;
      end
      else if (((pil='o')or(pil='O'))and((caris=false)and(carip=false)and(caric=false))) then
      begin
        k := 3;
        ganti := true;
      end
      else if (((pil='r')or(pil='R'))and((caris=false)and(carip=false)and(caric=false))) then
      begin
        k := 2;
        ganti := true;
      end
      else if (((pil='c')or(pil='C'))and((caris=false)and(carip=false)and(caric=false))) then
      begin
        k := 4;
        ganti := true;
      end
      else if (((pil='d')or(pil='D'))and((caris=false)and(carip=false)and(caric=false))) then
      begin
        gotoxy(1,29);clreol;write('Customer ID : ');readln(cari2);
        jm := 0;
        for j := 1 to js-1 do
          if (cari2=st[j].id) then
          begin
            jm := jm +1;
            ketemu[jm] := j;
          end;
        if (jm=0) then
        begin
          gotoxy(25,29);textcolor(red);write('Invalid Input');readln;
          textcolor(15);gotoxy(25,29);clreol;
        end
        else
          caris := true;
      end
      else if (((pil='u')or(pil='U'))and((caris=false)and(carip=false)and(caric=false))) then
      begin
        gotoxy(15,29);clreol;
        gotoxy(1,13);writeln('|                                                                              |');
        gotoxy(1,14);writeln('|                                                                              |');
        gotoxy(1,15);writeln('|                                                                              |');
        gotoxy(1,16);writeln('|                                                                              |');
        gotoxy(1,17);writeln('|                      SEARCH BY N[A]ME                                        |');
        gotoxy(1,18);writeln('|                                                                              |');
        gotoxy(1,19);writeln('|                      SEARCH BY [I]D CUSTOMER                                 |');
        gotoxy(1,20);writeln('|                                                                              |');
        gotoxy(1,21);writeln('|                                                                              |');
        gotoxy(1,22);writeln('|                                                                              |');
        gotoxy(1,23);writeln('|                                                                              |');
        gotoxy(1,24);writeln('|                                                                              |');
        gotoxy(1,25);writeln('|                                                                              |');
        gotoxy(1,26);writeln('|                                                                              |');
        gotoxy(1,27);writeln('|                                                                              |');
        gotoxy(1,28);writeln('+------------------------------------------------------------------------------+');
        gotoxy(1,29);write('Select Menu : ');readln(pil);
        while ((pil<>'a')and(pil<>'A')and(pil<>'i')and(pil<>'I')) do
        begin
          gotoxy(25,29);textcolor(red);write('Invalid Input');readln;
          textcolor(15);gotoxy(15,29);clreol;readln(pil);
        end;
        caric := true;
      end
      else if (((pil='p')or(pil='P'))and((caris=false)and(carip=false)and(caric=false))) then
      begin
        gotoxy(15,29);clreol;
        gotoxy(1,13);writeln('|                                                                              |');
        gotoxy(1,14);writeln('|                                                                              |');
        gotoxy(1,15);writeln('|                                                                              |');
        gotoxy(1,16);writeln('|                                                                              |');
        gotoxy(1,17);writeln('|                      SEARCH BY N[A]ME                                        |');
        gotoxy(1,18);writeln('|                                                                              |');
        gotoxy(1,19);writeln('|                      SEARCH BY [I]D                                          |');
        gotoxy(1,20);writeln('|                                                                              |');
        gotoxy(1,21);writeln('|                      SEARCH BY [C]ATEGORY                                    |');
        gotoxy(1,22);writeln('|                                                                              |');
        gotoxy(1,23);writeln('|                                                                              |');
        gotoxy(1,24);writeln('|                                                                              |');
        gotoxy(1,25);writeln('|                                                                              |');
        gotoxy(1,26);writeln('|                                                                              |');
        gotoxy(1,27);writeln('|                                                                              |');
        gotoxy(1,28);writeln('+------------------------------------------------------------------------------+');
        gotoxy(1,29);write('Select Menu : ');readln(pil2);
        while ((pil2<>'a')and(pil2<>'A')and(pil2<>'i')and(pil2<>'I')and(pil2<>'c')and(pil2<>'C')) do
        begin
          gotoxy(25,29);textcolor(red);write('Invalid Input');readln;
          textcolor(15);gotoxy(15,29);clreol;readln(pil2);
        end;
        carip := true;
      end
      else if (((pil='f')or(pil='F'))and((caris)or(carip)or(caric))) then
      begin
        for j := 1 to jm do
        begin
          ketemu[j] := 0;
        end;
        for j := 1 to l do
          hal[j] :=0;
        l := 1;
        n := 1;
        i := 1;
        caris := false;
        carip := false;
        caric := false;
      end
      else
      begin
        gotoxy(25,29);textcolor(red);write('Invalid Input');readln;
        textcolor(15);gotoxy(25,29);clreol;
        i := n1;
      end;
    until (ganti);
  end;

BEGIN
     textcolor(15);
     assign(arsipo,'barang.txt');
     reset(arsipo);
     jb:=0;
     while (not eof(arsipo)) do
     begin
          jb := jb + 1;
     read(arsipo,b[jb]);
     end;
     assign(arsips,'transaksi.txt');
     js := 0;
     reset(arsips);
     while (not eof(arsips)) do
     begin
          js := js + 1;
          read(arsips,s[js]);
     end;
     assign(arsipp,'user.txt');
     jp := 0;
     reset(arsipp);
     while (not eof(arsipp)) do
     begin
          jp := jp + 1;
          read(arsipp,p[jp]);
     end;
     keluar := false;
     kode := 0;
     repeat
           login(pass,user);
           if ((user<>'admin') or (pass<>'meledak')) then
           begin
                gotoxy(3,13);writeln('Username atau Password salah!');
           end;
     until ((user='admin') and (pass='meledak'));
     repeat
     textcolor(15);
     clrscr;
     if (kode = 0) then
     begin
      home();
      gotoxy(1,29);write('Select Menu : ');readln(pil);
      if ((pil = 'H') or (pil = 'h')) then
        menu := 1
      else
        if ((pil = 'R') or (pil = 'r')) then
          menu := 2
        else
          if ((pil = 'O') or (pil = 'o')) then
            menu := 3
          else
            if ((pil = 'C') or (pil = 'c')) then
              menu := 4
            else
              if ((pil = 'S') or (pil = 's')) then
                menu := 5
              else
                if (pil = '0') then
                  keluar := true
                else
                begin
                  gotoxy(15,29);clreol;textcolor(red);write('Invalid Input');readln;
                  textcolor(15);gotoxy(15,29);clreol;
                end;
     end
     else
       menu := kode;
       kode := 0;
     case menu of
     1 : kode := 0;
     2 : begin
          clrscr;
          product(b,kode,jb);
        end;
     3 : begin
          clrscr;
          order(s,js,kode);
        end;
     4 : begin
          clrscr;
          customer(p,kode,jp);
        end;
     5 : begin
          clrscr;
          search(b,s,p,jb,js,jp,kode);
        end;
     end;
     menu := 0;
   until(keluar);
   rewrite(arsips);
   rewrite(arsipo);
   rewrite(arsipp);
   for count := 2 to js do
     write(arsips,s[count]);
   for count := 2 to jb do
     write(arsipo,b[count]);
   for count := 2 to jp do
     write(arsipp,p[count]);
   close(arsipp);
   close(arsips);
   close(arsipo);
end.
