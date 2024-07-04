class ProdukModal {
  final int id;
  final String judul;
  final String kategori;
  final num harga;
  final int terjual;
  final num rating;
  final String deskripsi;
  final String gambar;
  bool isFavorit;

  ProdukModal(
      {required this.judul,
      required this.kategori,
      required this.harga,
      required this.terjual,
      required this.rating,
      required this.deskripsi,
      required this.gambar,
      required this.id,
      this.isFavorit = false
      });

  factory ProdukModal.fromJson(Map<String, dynamic> json) {
    return ProdukModal(
      id: json['id'] as int,
      judul: json['title'] as String,
      kategori: json['category'] as String,
      harga: json['price'] as num,
      terjual: json['rating']['count'] as int,
      rating: json['rating']['rate'] as num,
      deskripsi: json['description'] as String,
      gambar: json['image'] as String,
    );
  }
}