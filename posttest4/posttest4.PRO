/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  
 FileName: CH04E12.PRO
 Purpose: 
 Written by: PDC
 Modifyed by: Eugene Akimov
 Comments: 
******************************************************************************/

domains
% domain untuk mengenal tipe data yang diberi
  name,sex,occupation,object,vice,substance = symbol 
  age=integer

predicates
% predicates penamaan yang diberi tipe data agar dapat dari dipanggil oleh clauses
  person(name,age,sex,occupation) - nondeterm (o,o,o,o), nondeterm (i,o,o,i), nondeterm (i,o,i,o)
  had_affair(name,name) - nondeterm (i,i), nondeterm (i,o) 
  killed_with(name,object) - determ (i,o) 
  killed(name) - procedure (o)
  killer(name) - nondeterm (o)
  motive(vice) - nondeterm (i)
  smeared_in(name,substance) - nondeterm (i,o), nondeterm (i,i)
  owns(name,object) - nondeterm (i,i)
  operates_identically(object,object) - nondeterm (o,i)
  owns_probably(name,object) - nondeterm (i,i)
  suspect(name) - nondeterm (i)

/* * * Facts about the murder * * */
%ini adalah fakta dari pembunuhan
clauses
%clauses pertama menjelaskan tentang orang
%orang memiliki nama,umur,jeniskelamin,pekerjaan
  person(bert,55,m,carpenter). % disini data diri orang(bert,55,lakilaki,tukang kayu)
  person(allan,25,m,football_player). % disini data diri orang(allan,25,lakilaki,pemain bola)
  person(allan,25,m,butcher).% disini data diri orang(allan,25,lakilaki,tukang daging)
  person(john,25,m,pickpocket).% disini data diri orang(john,55,lakilaki,pencopet)

  had_affair(barbara,john). %barbara memilki hubungan dengan john
  had_affair(barbara,bert).%barbara memilki hubungan dengan bert
  had_affair(susan,john).%susan memilki hubungan dengan john

  killed_with(susan,club). %susan disni dibunuh ketika berada diclub
  killed(susan).%orang yang dibunuh adalah susan

  motive(money).%tujuannya kemungkinan adalah uang
  motive(jealousy). %tujuannya kemungkinan adalah kecemburuan
  motive(righteousness).% tujuannya kemungkinan adalah keadilan

  smeared_in(bert,blood). %dikejadian bert berlumuran darah
  smeared_in(susan,blood). %dikejadian bert berlumuran darah
  smeared_in(allan,mud). %dikejadian bert berlumuran lumpur
  smeared_in(john,chocolate). %dikejadian bert berlumuran coklat
  smeared_in(barbara,chocolate). %dikejadian bert berlumuran coklat

  owns(bert,wooden_leg). %pada kejadian itu bert memiliki kaki palsu
  owns(john,pistol). %pada kejadian itu john memiliki pistol

/* * * Background knowledge * * */
 %adalah dibalik kejadian tersebut
 
  operates_identically(wooden_leg, club). %benda woooden leg disini bisa digunakan sebagai pemukul
  operates_identically(bar, club). % benda bar disini juga bisa dipakai sebagai pemukul
  operates_identically(pair_of_scissors, knife). %benda pair of scissors disini bisa dijadikan sebagai pisau/penusuk
  operates_identically(football_boot, club). %benda football boot juga bisa digunakan sebagai pemukul

%kemungkinan kepemilikan
  owns_probably(X,football_boot):- % x adalah kemungkinan yang memiliki sepatu bola
	person(X,_,_,football_player). %orang si X adalah pemain sepak bola
  owns_probably(X,pair_of_scissors):- % x adalah kemungkinan yang memiliki sepasang gunting
	person(X,_,_,hairdresser).%orang si X adalah penata rambut
  owns_probably(X,Object):-% x adalah kemungkinan yang memiliki benda
	owns(X,Object).%orang si X adalah yang memiliki benda

/* * * * * * * * * * * * * * * * * * * * * * *
 * Suspect all those who own a weapon with   *
 * which Susan could have been killed.       *
 * * * * * * * * * * * * * * * * * * * * * * */


  suspect(X):-%bagaimana suatu tersangka dapat diketahui 
	killed_with(susan,Weapon) , %pembunuh ini membunuh susan menggunakan senjata
	operates_identically(Object,Weapon) , %operasi penelusurannya mendapatkan benda berupa senjata
	owns_probably(X,Object). %memiliki hubungan antara si pelaku X dengan benda yang dijadikan pelaku

/* * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect men who have had an affair with Susan.  *
 * * * * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):- %pelaku dapat diketahui jika
	motive(jealousy),% mempunyai motive karena kecemburuaan
	person(X,_,m,_), %orang disini si X yang memiliki tipe data m atau laki laki yang telah dijelaskan  diatas
	had_affair(susan,X). %sipelaku X memiliki hubungan dengan sikorban susan

/* * * * * * * * * * * * * * * * * * * * *
 * Suspect females who have had an       *
 * affair with someone that Susan knew.  *
 * * * * * * * * * * * * * * * * * * * * */

  suspect(X):- %maka tersangka dapat diketahui
	motive(jealousy), % mempunyai motive karena kecemburuaan
	person(X,_,f,_),%orang disini si X yang memiliki tipe data f atau perempuan yang telah dijelaskan  diatas
	had_affair(X,Man),%sipelaku memiliki hubungan dengan laki laki
	had_affair(susan,Man). %dan korban susan memiliki hubungan dengan lakilaki itu

/* * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect pickpockets whose motive could be money.  *
 * * * * * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):- %tersangka dapat diketahui jika
	motive(money), %mempunyai motive karena uang
	person(X,_,_,pickpocket). %si orang ini dan X memiliki pekerjaan menjadi pencopet

  killer(Killer):- %bagaimana cara mengetahui si pembunuh
	person(Killer,_,_,_), %orang ini adalah salah satunya adalah pembunuh
	killed(Killed), %si korban masuk pada variabel dibunuh
	Killed <> Killer, /* It is not a suicide */ % yang membunuh dan yang dibunuh bukan orang yang sama
	suspect(Killer), %tersangka adalah pembunuh
	smeared_in(Killer,Goo), %pembunuh terindetifikasi berlumuran dengan suatu cairan
	smeared_in(Killed,Goo). %orang yang dibunuh juga berlumuran dengan suatu cairan

goal
  killer(X). %dan pelakunya adalah bert pertama dicek kedua karena bukan orang yang sama ketiga senjatanya bisa digunakan sebagai tongkat keempat dan ada bukti berlumuran darah  itu penyebabnya
