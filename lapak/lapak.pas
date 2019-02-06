program lapak;
{IS : program meminta pengguna untuk memilih sebuah menu pilihan
FS : pengguna dapat melaksanakan fitur-fitur yang disediakan
Author : Ubassy Abdillah, Dzakyta Afuzagani, Akhmad Fadilah Ramadhan, Mohammad Zakie Faiz Rahiemy}
uses crt;
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
  keluar : boolean;
  arsipo : file of barang;
  arsips : file of struk;
  arsipp : file of pembeli;
  b:array [1..50] of barang;
  s:array [1..1000] of struk;
  p:array[1..100] of pembeli;
  z,y,x,kode,menu,count:integer;
  pil : string;


  Procedure store(var ob : array of barang;var k,jo,jp,js : integer;var st : array of struk; var pe : array of pembeli);
  {IS : menampilkan daftar produk yang tersedia dan jumlah stok, harga satuan, dan kategori dari produk tersebut
   FS : jika pengguna memilih order, akan diminta mengisi identitas pelanggan dan barang-barang yang akan dibeli}
  var
    ganti,order : boolean;
    pil,id : string;
    n,i,ketemu,j,k2 : integer;
    temp : barang;
  begin
    n := 1;
    order := false;
    repeat
      textcolor(15);
      ganti := false;
      k := 0;
      ketemu := 0;
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
      gotoxy(1,11);write('|   [H]OME   |   [S]TORE   |  [D]IRECTORY  |  [O]RDER TRACKING  |   S[E]ARCH   |');
      gotoxy(1,12);write('+--+--------++-------------+---------+-----+-+-------------+----+--------------+');
      gotoxy(1,13);write('|No|  id    |       Item Name        | Stock |    Price    |      Category     |');
      gotoxy(1,14);write('+--+--------+------------------------+-------+-------------+-------------------+');
      gotoxy(1,15);writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');
      writeln('|');writeln('|');writeln('|');
      write('+--+--------+------------------------+-------+-------------+-------------------+');
      gotoxy(80,15);write('|');
      gotoxy(80,16);write('|');gotoxy(80,17);write('|');
      gotoxy(80,18);write('|');gotoxy(80,19);write('|');
      gotoxy(80,20);write('|');gotoxy(80,21);write('|');
      gotoxy(80,22);write('|');gotoxy(80,23);write('|');
      gotoxy(80,24);write('|');gotoxy(80,25);write('|');
      gotoxy(80,26);write('|');gotoxy(80,27);write('|');
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
      if (order=false) then
      begin
        gotoxy(1,30);write('[P]REV      SORT N[A]ME          O[R]DER          SORT [I]D              [N]EXT');
        gotoxy(77,29);write((n div 13)+1,'/',(jo div 13)+1);
        gotoxy(1,29);write('Select Menu : ');readln(pil);
      end
      else
      begin
        gotoxy(1,30);write('[P]REV                          [F]INISH                                 [N]EXT');
        gotoxy(77,29);write((n div 13)+1,'/',(jo div 13)+1);
        gotoxy(1,29);write('Item ID : ');readln(pil);
      end;
      if (((pil='r')or(pil='R'))and(order=false)) then
      begin
        gotoxy(1,29);clreol;write('Customer ID : ');readln(id);
        if (jp=0) then
        begin
           clrscr;
           pe[1].idp:=id;
           gotoxy(31,3);write('REGISTRATION FORM');
           gotoxy(23,4);write('+--------------------------------+');
           gotoxy(23,5);write('| Name         : ');gotoxy(56,5);write('|');
           gotoxy(23,6);write('| Address      : ');gotoxy(56,6);write('|');
           gotoxy(23,7);write('| Phone Number : ');gotoxy(56,7);write('|');
           gotoxy(23,8);write('+--------------------------------+');
           gotoxy(40,5);readln(pe[1].namap);
           gotoxy(40,6);readln(pe[1].alm);
           gotoxy(40,7);readln(pe[1].notelp);
           jp := 1;
           js := js + 1;
           st[js-1].id := pe[jp].idp;
           st[js-1].jum := 0;
        end
        else
        begin
          for i := 1 to jp do
          begin
            if (pe[i].idp=id) then
              ketemu := i;
          end;
          if (ketemu = 0) then
          begin
            clrscr;
            jp := jp+1;
            pe[jp-1].idp:=id;
            gotoxy(31,3);write('REGISTRATION FORM');
            gotoxy(23,4);write('+--------------------------------+');
            gotoxy(23,5);write('| Name         : ');gotoxy(56,5);write('|');
            gotoxy(23,6);write('| Address      : ');gotoxy(56,6);write('|');
            gotoxy(23,7);write('| Phone Number : ');gotoxy(56,7);write('|');
            gotoxy(23,8);write('+--------------------------------+');
            gotoxy(40,5);readln(pe[jp-1].namap);
            gotoxy(40,6);readln(pe[jp-1].alm);
            gotoxy(40,7);readln(pe[jp-1].notelp);
            js := js + 1;
            st[js-1].id := pe[jp-1].idp;
            st[js-1].jum := 0;
          end
          else
          begin
            js := js + 1;
            st[js-1].jum := 0;
            st[js-1].id := pe[ketemu].idp;
          end;
        end;
        order := true;
      end
      else if ((pil = 'n')or(pil='N')) then
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
      else
      begin
        if ((pil = 'p')or(pil='P')) then
        begin
          n := n - 13;
          if (n < 0) then
          begin
            gotoxy(25,29);textcolor(red);write('Invalid Input');readln;
            textcolor(15);gotoxy(25,29);clreol;
            n := n + 13;
          end;
        end
        else if ((pil='a')or(pil='A')) then
        begin
          for j := jo-1 downto 2 do
          begin
            for k2 := 2 to j do
            begin
              if (ob[k2-1].namao>ob[k2].namao) then
              begin
                temp := ob[k2-1];
                ob[k2-1] := ob[k2];
                ob[k2] := temp;
              end;
            end;
          end;
        end
        else if ((pil='i')or(pil='I')) then
        begin
          for j := jo-1 downto 2 do
          begin
            for k2 := 2 to j do
            begin
              if (ob[k2-1].kodeo>ob[k2].kodeo) then
              begin
                temp := ob[k2-1];
                ob[k2-1] := ob[k2];
                ob[k2] := temp;
              end;
            end;
          end;
        end
        else if (((pil='h')or(pil='H'))and(order=false)) then
        begin
          k := 1;
          ganti := true;
        end
        else if (((pil='d')or(pil='D'))and(order=false)) then
        begin
          k := 3;
          ganti := true;
        end
        else if (((pil='o')or(pil='O'))and(order=false)) then
        begin
          k := 4;
          ganti := true;
        end
        else if (((pil='e')or(pil='E'))and(order=false)) then
        begin
          k := 5;
          ganti := true;
        end
        else if (((pil='f')or(pil='F'))and(order)) then
        begin
          st[js-1].total := 0;
          for i := 1 to st[js-1].jum do
            st[js-1].total := st[js-1].total + st[js-1].be[i].hargab*st[js-1].be[i].jmlhb;
          clrscr;
          gotoxy(9,3);write('+---+-----------+-------+-----------+------+---------------+');
          gotoxy(9,4);write('|No.|Customer ID|Item ID|   Price   |Amount|     Total     |');
          gotoxy(9,5);write('+---+-----------+-------+-----------+------+---------------+');
          gotoxy(9,6);write('| ',js-1);gotoxy(13,6);write('| ',st[js-1].id);gotoxy(25,6);write('| ',st[js-1].be[1].kodeb);
          gotoxy(33,6);write('|Rp.',st[js-1].be[1].hargab);gotoxy(45,6);write('| ',st[js-1].be[1].jmlhb);gotoxy(52,6);write('|');
          gotoxy(68,6);write('|');
          if(st[js-1].jum>1) then
          begin
            for i := 2 to st[js-1].jum do
            begin
              gotoxy(9,5+i);write('| ');gotoxy(13,5+i);write('| ');gotoxy(25,5+i);write('| ',st[js-1].be[i].kodeb);
              gotoxy(33,5+i);write('|Rp.',st[js-1].be[i].hargab);gotoxy(45,5+i);write('| ',st[js-1].be[i].jmlhb);gotoxy(52,5+i);write('|');
              gotoxy(68,5+i);write('|');
            end;
            gotoxy(52,5+i);write('|Rp.',st[js-1].total:0:2);
            gotoxy(9,6+i);write('+---+-----------+-------+-----------+------+---------------+');
            order := false;
            readln;
          end
          else
          begin
            gotoxy(52,6);write('|Rp.',st[js-1].total:0:2);
            gotoxy(9,7);write('+---+-----------+-------+-----------+------+---------------+');
            order := false;
            readln;
          end;
        end
        else if (order=true) then
        begin
          for i := 1 to jo do
          begin
            if (pil=ob[i].kodeo) then
              ketemu := i;
          end;
          if (ketemu=0) then
          begin
            gotoxy(25,29);textcolor(red);write('Invalid Input');readln;
            textcolor(15);gotoxy(25,29);clreol;
          end
          else
          begin
            st[js-1].jum := st[js-1].jum + 1;
            st[js-1].be[st[js-1].jum].kodeb := ob[ketemu].kodeo;
            st[js-1].be[st[js-1].jum].namab := ob[ketemu].namao;
            gotoxy(1,29);clreol;write('Quantity : ');readln(st[js-1].be[st[js-1].jum].jmlhb);
            while (ob[ketemu].jmlho-st[js-1].be[st[js-1].jum].jmlhb<0) do
            begin
              gotoxy(25,29);textcolor(red);write('Out of stock');readln;
              textcolor(15);gotoxy(12,29);clreol;gotoxy(77,29);write((n div 13)+1,'/',(jo div 13)+1);
              gotoxy(12,29);readln(st[js-1].be[st[js-1].jum].jmlhb);
            end;
            ob[ketemu].jmlho:=ob[ketemu].jmlho-st[js-1].be[st[js-1].jum].jmlhb;
            st[js-1].be[st[js-1].jum].hargab := ob[ketemu].hargao;
          end;
        end
        else
        begin
          gotoxy(25,29);textcolor(red);write('Invalid Input');readln;
          textcolor(15);gotoxy(25,29);clreol;
          gotoxy(77,29);write((n div 13)+1,'/',(jo div 13)+1);
        end;
      end;
    until(ganti);
  end;


  procedure deskripsi(ob : array of barang;var k,jo : integer);
{IS : menampilkan daftar produk yang tersedia dan penggalan deskripsi, sejarah, dan lokasi dari produk tersebut
FS : jika pengguna memilih nomor produk, akan muncul deskripsi dan sejarah lengkap dari produk tersebut}
var
   n,i,j,ketemu,pake,kata,butuh,baris:integer;
   ganti,view:boolean;
   id:string;
begin
     n := 1;
     ganti:=false;
     repeat
           ganti := false;
           view:=false;
           k := 0;
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
           gotoxy(1,11);write('|   [H]OME   |   [S]TORE   |  [D]IRECTORY  |  [O]RDER TRACKING  |   S[E]ARCH   |');
           gotoxy(1,12);write('+--+-------+------------------------+------------------------------------------+');
           gotoxy(1,13);write('|No|Item ID|       Item Name        |               Description                |');       {deskripsi 42 karakter}
           gotoxy(1,14);write('+--+-------+------------------------+------------------------------------------+');
           gotoxy(1,15);writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');
           writeln('|');writeln('|');writeln('|');
           write('+--+-------+------------------------+------------------------------------------+');
           gotoxy(80,15);write('|');
           gotoxy(80,16);write('|');gotoxy(80,17);write('|');
           gotoxy(80,18);write('|');gotoxy(80,19);write('|');
           gotoxy(80,20);write('|');gotoxy(80,21);write('|');
           gotoxy(80,22);write('|');gotoxy(80,23);write('|');
           gotoxy(80,24);write('|');gotoxy(80,25);write('|');
           gotoxy(80,26);write('|');gotoxy(80,27);write('|');
           //mulai isi data
           if ((jo-n) div 13 = 0) then
           begin
              for i := 1 to ((jo-n) mod 13) do
              begin
                   gotoxy(4,i+14);write('|');gotoxy(12,i+14);write('|');gotoxy(37,i+14);write('|');
                   gotoxy(2,i+14);write(i);
                   gotoxy(6,i+14);write(ob[i+n-1].kodeo);
                   gotoxy(14,i+14);write(ob[i+n-1].namao);
                   gotoxy(39,i+14);
                    if(length(ob[i+n-1].des)<=53)then
                     write(ob[i+n-1].des)
                    else
                     begin
                     for j:=1 to 37 do
                     begin
                          write(ob[i+n-1].des[j]);
                     end;
                     write('...');
                     end;
              end;
              for i := ((jo-n) mod 13) to 13 do
              begin
                   gotoxy(4,i+14);write('|');gotoxy(12,i+14);write('|');gotoxy(37,i+14);write('|');
              end;
           end
           else
               for i := 1 to 13 do
               begin
                    gotoxy(4,i+14);write('|');gotoxy(12,i+14);write('|');gotoxy(37,i+14);write('|');
                    gotoxy(2,i+14);write(i);
                    gotoxy(6,i+14);write(ob[i+n-1].kodeo);
                    gotoxy(14,i+14);write(ob[i+n-1].namao);
                    gotoxy(39,i+14);
                    if(length(ob[i+n-1].des)<=53)then
                     write(ob[i+n-1].des)
                    else
                     begin
                     for j:=1 to 37 do
                     begin
                          write(ob[i+n-1].des[j]);
                     end;
                     write('...');
                     end;
               end;
        if (view=false) then
        begin
             gotoxy(1,30);write('[P]REV                           [V]IEW                                  [N]EXT');
             gotoxy(77,29);write((n div 13)+1,'/',(jo div 13)+1);
             gotoxy(1,29);write('Select Menu : ');readln(pil);
        end
        else
        begin
             gotoxy(1,30);write('[P]REV                           [V]IEW                                  [N]EXT');
             gotoxy(77,29);write((n div 13)+1,'/',(jo div 13)+1);
             gotoxy(1,29);write('Item ID : ');readln(pil);
        end;
        if (((pil='v')or(pil='V'))and(view=false)) then
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
             gotoxy(25,29);clreol;textcolor(red);write('Invalid Input');
             textcolor(15);gotoxy(77,29);write((n div 13)+1,'/',(jo div 13)+1);readln;
             gotoxy(25,29);clreol;
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
            gotoxy(1,11);write('|   [H]OME   |   [S]TORE   |  [D]IRECTORY  |  [O]RDER TRACKING  |   S[E]ARCH   |');
            gotoxy(1,12);write('+------------+-------------+---------------+-----------------------------------+');
            gotoxy(1,13);write('| Item ID    |             | Item Name     |                                   |');       {deskripsi 42 karakter}
            gotoxy(1,14);write('+------------+-------------+---------------+-----------------------------------+');
            gotoxy(1,15);write('| Price      |             | Category      |                                   |');
            gotoxy(1,16);write('+------------+-------------+---------------+-----------------------------------+');
            gotoxy(1,17);write('| Deskripsi  |');
            gotoxy(1,18);write('+------------+');
            gotoxy(1,19);writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');writeln('|');
            write('+------------------------------------------------------------------------------+');
            gotoxy(28,29);write('PRESS [ENTER] TO GO BACK');
            gotoxy(80,17);write('|');
            gotoxy(80,18);write('|');gotoxy(80,19);write('|');
            gotoxy(80,20);write('|');gotoxy(80,21);write('|');
            gotoxy(80,22);write('|');gotoxy(80,23);write('|');
            gotoxy(80,24);write('|');gotoxy(80,25);write('|');
            gotoxy(80,26);write('|');gotoxy(80,27);write('|');
            gotoxy(16,13);write(ob[ketemu].kodeo);
            gotoxy(46,13);write(ob[ketemu].namao);
            gotoxy(16,15);write('Rp.',ob[ketemu].hargao);
            gotoxy(46,15);write(ob[ketemu].kat);
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
            gotoxy(1,29);
            readln;
        end;
      end
      else if ((pil = 'n')or(pil='N')) then
      begin
        n := n + 13;
        if (n>jo) then
        begin
          gotoxy(25,29);clreol;textcolor(red);write('Invalid Input');
          textcolor(15);gotoxy(77,29);write((n div 13),'/',(jo div 13)+1);readln;
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
            gotoxy(25,29);clreol;textcolor(red);write('Invalid Input');
            textcolor(15);gotoxy(77,29);write((n div 13)+1,'/',(jo div 13)+1);readln;
            textcolor(15);gotoxy(25,29);clreol;
            n := n + 13;
          end;
        end
        else if (((pil='h')or(pil='H'))and(view=false)) then
        begin
          k := 1;
          ganti := true;
        end
        else if (((pil='s')or(pil='S'))and(view=false)) then
        begin
          k := 2;
          ganti := true;
        end
        else if (((pil='o')or(pil='O'))and(view=false)) then
        begin
          k := 4;
          ganti := true;
        end
        else if (((pil='e')or(pil='E'))and(view=false)) then
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
          gotoxy(25,29);clreol;textcolor(red);write('Invalid Input');
          textcolor(15);gotoxy(77,29);write((n div 13)+1,'/',(jo div 13)+1);readln;
          textcolor(15);gotoxy(25,29);clreol;
        end;
      end;
     until(ganti);
  end;


  procedure ordertrack(var st : array of struk; js:integer; var k : integer);
  {IS : pengguna memasukkan id pengguna ke dalam kolom yang disediakan
   FS : menampilkan daftar data barang yang dibeli beserta status transaksi tersebut}
  var
    baris,i,j,k1,l,n0,n1,jm : integer;
    hal : array [1..10] of integer;
    ketemu : array [1..50] of integer;
    pil,cari2 : string;
    ganti,cari,no : boolean;
  begin
    ganti := false;
    for j := 1 to js do
      st[j].stat := 'Awaiting Payment';
    cari := false;
    i := 1;
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
      gotoxy(1,10);write('+------------+-------------+---------------+--------------------+--------------+');
      gotoxy(1,11);write('|   [H]OME   |   [S]TORE   |  [D]IRECTORY  |  [O]RDER TRACKING  |   S[E]ARCH   |');
      if (cari=false) then
      begin
        gotoxy(1,12);write('+----+-------+-----+-------+-----+---------+-------------+------+--------------+');
        gotoxy(1,13);write('| No | Customer ID |   Item ID   |       Item Name       |        Status       |');
        gotoxy(1,14);write('+----+-------------+-------------+-----------------------+---------------------+');
        gotoxy(1,28);write('+----+-------------+-------------+-----------------------+---------------------+');
        for j := 1 to 13 do
        begin
            gotoxy(1,14+j);write('| ');gotoxy(6,14+j);write('| ');gotoxy(20,14+j);write('| ');
            gotoxy(34,14+j);write('| ');gotoxy(58,14+j);write('| ');gotoxy(80,14+j);write('|');
        end;
        gotoxy(1,30);write('                                F[I]ND                                       ');
        gotoxy(1,29);write('Select Menu : ');readln(pil);
      end
      else
      begin
        gotoxy(1,12);write('+----+-------+-----+-------+-----+---------+-------------+------+--------------+');
        gotoxy(1,13);write('| No | Customer ID |   Item ID   |       Item Name       |        Status       |');
        gotoxy(1,14);write('+----+-------------+-------------+-----------------------+---------------------+');
        gotoxy(1,28);write('+----+-------------+-------------+-----------------------+---------------------+');
        n1 := i;
        while ((baris+st[ketemu[i]].jum<15)and(i<=jm)) do
        begin
          gotoxy(1,14+baris);write('| ',ketemu[i]);gotoxy(6,14+baris);write('| ',st[ketemu[i]].id);gotoxy(20,14+baris);write('| ',st[ketemu[i]].be[1].kodeb);
          gotoxy(34,14+baris);write('| ',st[ketemu[i]].be[1].namab);gotoxy(58,14+baris);write('| ');gotoxy(80,14+baris);write('|');
          gotoxy(58,14+baris);write('| ',st[ketemu[i]].stat);
          if (st[ketemu[i]].jum>1) then
          begin
            for j := 2 to st[ketemu[i]].jum do
            begin
              baris := baris+1;
              gotoxy(1,14+baris);write('| ');gotoxy(6,14+baris);write('| ');gotoxy(20,14+baris);write('| ',st[ketemu[i]].be[j].kodeb);
              gotoxy(34,14+baris);write('| ',st[ketemu[i]].be[j].namab);gotoxy(58,14+baris);write('| ');gotoxy(80,14+baris);write('|');
            end;
            baris := baris+1;
          end
          else
          begin
            gotoxy(58,14+baris);write('| ',st[ketemu[i]].stat);
            baris := baris+1;
          end;
          i := i+1;
        end;
        if (baris<14) then
        begin
          for j := baris to 13 do
          begin
            gotoxy(1,14+baris);write('| ');gotoxy(6,14+baris);write('| ');gotoxy(20,14+baris);write('| ');
            gotoxy(34,14+baris);write('| ');gotoxy(58,14+baris);write('| ');gotoxy(80,14+baris);write('|');
            baris := baris +1;
          end;
        end;
        no := false;
        if (l>1) then
          for j := 1 to l do
            if (n1=hal[j]) then
              no := true;
        if (no = false) then
        begin
          hal[l] := n1;
          l := l+1;
        end;
        gotoxy(1,30);write('[P]REV                          [F]INISH                                 [N]EXT');
        gotoxy(1,29);write('Select Menu : ');readln(pil);
      end;
      if (((pil = 'n')or(pil='N'))and(cari)) then
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
      else if (((pil = 'p')or(pil='P'))and(cari)) then
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
      else if (((pil='h')or(pil='H'))and(cari=false)) then
      begin
        k := 1;
        ganti := true;
      end
      else if (((pil='d')or(pil='D'))and(cari=false)) then
      begin
        k := 3;
        ganti := true;
      end
      else if (((pil='s')or(pil='S'))and(cari=false)) then
      begin
        k := 2;
        ganti := true;
      end
      else if (((pil='e')or(pil='E'))and(cari=false)) then
      begin
        k := 5;
        ganti := true;
      end
      else if (((pil='i')or(pil='I'))and(cari=false)) then
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
          cari := true;
      end
      else if (((pil='f')or(pil='F'))and(cari)) then
      begin
        for j := 1 to jm do
        begin
          ketemu[j] := 0;
        end;
        for j := 1 to l do
          hal[j] :=0;
        l := 1;
        i := 1;
        cari := false;
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
   FS : menampilkan daftar data sesuai kata kunci yang telah dimasukkan}
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
      gotoxy(1,10);write('+------------+-------------+---------------+--------------------+--------------+');
      gotoxy(1,11);write('|   [H]OME   |   [S]TORE   |  [D]IRECTORY  |  [O]RDER TRACKING  |   S[E]ARCH   |');
      if ((caris=false)and(carip=false)and(caric=false)) then
      begin
        gotoxy(1,12);writeln('+------------+-------------+---------------+--------------------+--------------+');
        gotoxy(1,13);writeln('|                                                                              |');
        gotoxy(1,14);writeln('|                                                                              |');
        gotoxy(1,15);writeln('|                                                                              |');
        gotoxy(1,16);writeln('|                                                                              |');
        gotoxy(1,17);writeln('|                      SEARCH BY O[R]DER                                       |');
        gotoxy(1,18);writeln('|                                                                              |');
        gotoxy(1,19);writeln('|                      SEARCH BY [C]CUSTOMER                                   |');
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
        gotoxy(1,11);write('|   [H]OME   |   [S]TORE   |  [D]IRECTORY  |  [O]RDER TRACKING  |   S[E]ARCH   |');
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
        gotoxy(1,11);write('|   [H]OME   |   [S]TORE   |  [D]IRECTORY  |  [O]RDER TRACKING  |   S[E]ARCH   |');
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
          gotoxy(1,11);write('|   [H]OME   |   [S]TORE   |  [D]IRECTORY  |  [O]RDER TRACKING  |   S[E]ARCH   |');
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
        gotoxy(1,11);write('|   [H]OME   |   [S]TORE   |  [D]IRECTORY  |  [O]RDER TRACKING  |   S[E]ARCH   |');
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
          gotoxy(1,11);write('|   [H]OME   |   [S]TORE   |  [D]IRECTORY  |  [O]RDER TRACKING  |   S[E]ARCH   |');
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
      else if (((pil='d')or(pil='D'))and((caris=false)and(carip=false)and(caric=false))) then
      begin
        k := 3;
        ganti := true;
      end
      else if (((pil='s')or(pil='S'))and((caris=false)and(carip=false)and(caric=false))) then
      begin
        k := 2;
        ganti := true;
      end
      else if (((pil='o')or(pil='O'))and((caris=false)and(carip=false)and(caric=false))) then
      begin
        k := 4;
        ganti := true;
      end
      else if (((pil='r')or(pil='R'))and((caris=false)and(carip=false)and(caric=false))) then
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
      else if (((pil='c')or(pil='C'))and((caris=false)and(carip=false)and(caric=false))) then
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


begin
  assign(arsipo,'barang.txt');
  z := 1;
  reset(arsipo);
  while (not eof(arsipo)) do
  begin
    z := z + 1;
    read(arsipo,b[z]);
  end;

  assign(arsips,'transaksi.txt');
  x := 1;
  reset(arsips);
  while (not eof(arsips)) do
  begin
    x := x + 1;
    read(arsips,s[x]);
  end;

  assign(arsipp,'user.txt');
  y := 1;
  reset(arsipp);
  while (not eof(arsipp)) do
  begin
    y := y + 1;
    read(arsipp,p[y]);
  end;

  keluar := false;
  kode := 0;
  repeat
    textcolor(15);
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
    gotoxy(1,11);writeln('|   [H]OME   |   [S]TORE   |  [D]IRECTORY  |  [O]RDER TRACKING  |   S[E]ARCH   |');
    gotoxy(1,12);writeln('+------------+-------------+---------------+--------------------+--------------+');
    gotoxy(1,13);writeln('|                                                                              |');
    gotoxy(1,14);writeln('|      Welcome to LAPAK. LAPAK is a program that help some shopman to sell     |');
    gotoxy(1,15);writeln('|    and manage their product easily. We hope our program will be useful       |');
    gotoxy(1,16);writeln('|    for many people.                                                          |');
    gotoxy(1,17);writeln('|                                                                              |');
    gotoxy(1,18);writeln('|                                                                              |');
    gotoxy(1,19);writeln('|                Press character between [ ] to continue                       |');
    gotoxy(1,20);writeln('|                                                                              |');
    gotoxy(1,21);writeln('|                                                                              |');
    gotoxy(1,22);writeln('|                                                                              |');
    gotoxy(1,23);writeln('|                                                                              |');
    gotoxy(1,24);writeln('|                                                                              |');
    gotoxy(1,25);writeln('|                                                                              |');
    gotoxy(1,26);writeln('|                                                                              |');
    gotoxy(1,27);writeln('|Copyright Re:Solute 2015                                       Press 0 to Exit|');
    gotoxy(1,28);writeln('+------------------------------------------------------------------------------+');
    if (kode = 0) then
    begin
      gotoxy(1,29);write('Select Menu : ');readln(pil);
      if ((pil = 'H') or (pil = 'h')) then
        menu := 1
      else
        if ((pil = 'S') or (pil = 's')) then
          menu := 2
        else
          if ((pil = 'D') or (pil = 'd')) then
            menu := 3
          else
            if ((pil = 'O') or (pil = 'o')) then
              menu := 4
            else
              if ((pil = 'E') or (pil = 'e')) then
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
          store(b,kode,z,y,x,s,p);
        end;
    3 : begin
          clrscr;
          deskripsi(b,kode,z);
        end;
    4 : begin
          clrscr;
          ordertrack(s,x,kode);
        end;
    5 : begin
          clrscr;
          search(b,s,p,z,x,y,kode);
        end;
    end;
    menu := 0;
  until(keluar);
  rewrite(arsips);
  rewrite(arsipo);
  rewrite(arsipp);
  for count := 2 to x do
     write(arsips,s[count]);
   for count := 2 to z do
     write(arsipo,b[count]);
   for count := 2 to y do
     write(arsipp,p[count]);
  close(arsipp);
  close(arsips);
  close(arsipo);;
end.
