DOMAINS
nama,kelamin,pekerjaan,benda,alasan = symbol
umur=long

PREDICATES
nondeterm orang(nama , umur , kelamin ,pekerjaan)
istri(nama, nama)
dibegal_dengan(nama, benda)
dibegal(nama)
nondeterm pembegal(nama)
motif(alasan)
milik(nama, benda)
nondeterm cara_kerja_dengan(benda, benda)
nondeterm kemungkinan_milik(nama, benda)
nondeterm dicurigai(nama)

CLAUSES
orang(adam,19,pria,tukang_ojek).
orang(budi,17,pria,manager).
orang(cinta,15,wanita,sekretaris).
orang(katon,12,pria,pembantu).

istri(prita,budi).

dibegal_dengan(prita,ditebas).
dibegal(prita).

motif(wanita).

milik(adam,carter).
milik(katon,katana).
milik(cinta,pistol).

cara_kerja_dengan(katana, ditebas).

kemungkinan_milik(X,Benda):-
	milik(X,Benda).


dicurigai(X):-
	dibegal_dengan(prita, Benda),
	cara_kerja_dengan(Benda,Benda),
	kemungkinan_milik(X,Benda).
	
dicurigai(X):-
	motif(wanita),
	orang(X,_,_,pembantu).

pembegal(Pembegal):-
	orang(Pembegal,_,_,_),
	dicurigai(Pembegal).
	
GOAL
pembegal(X).

%ini adalah kasus pembegalan
%dimana disini terdapat orang orang yang dicurigai sebagai tersangka seperti katon,budi,adam dan dony
%korban yang bernama prita yang dibunuh begal
%terdapat indentitas orang orang yang dicurigai sebagai tersangka
%ada juga barang bukti seperti katana,carter dan pistol
%dalam program ini memliki konsep cara kerja tersendiri dengan melihat dari cara kerjanya dan kemungkinanya
%dan terakhir akan terlihat siapa pelaku pembegalan tersebut
