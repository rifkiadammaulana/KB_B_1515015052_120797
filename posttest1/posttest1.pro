domains
  kali,tambah,kurang,bagi = integer %kata disamping menunjukan tipe data yang menunjukan bilangan bulat

predicates
  tambahkan(tambah,tambah,tambah) - procedure (i,i,o) %bentuk dari input output yang telah kita buat 
  perkalian(kali,kali,kali) - procedure (i,i,o) %bentuk dari input output yang telah kita buat
  pengurangan(kurang,kurang,kurang) - procedure (i,i,o) %bentuk dari input output yang telah kita buat
  pembagian(bagi,bagi,bagi) - procedure (i,i,o)%bentuk dari input output yang telah kita buat
clauses
  tambahkan(A,B,Tambah):- %kemungkinan kemungkinan yang akan terjadi misalkan ini pertambahan
	Tambah=A+B.
  pengurangan(A,B,Kurang):- %kemungkinan kemungkinan yang akan terjadi misalkan ini pengurangan
	Kurang=A-B.
  perkalian(A,B,Kali):- %kemungkinan kemungkinan yang akan terjadi misalkan ini perkalian
	Kali=A*B.
  pembagian(A,B,Bagi):- %kemungkinan kemungkinan yang akan terjadi misalkan ini pembagian
 	Bagi=A/B.
goal
  pengurangan(32,54,Kurang) %ingin menghasilkan pengurangan dari 32-54