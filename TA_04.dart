import 'dart:io';

class Paket {
  String namaPengirim;
  String tujuan;
  double beratKg;

  Paket(this.namaPengirim, this.tujuan, this.beratKg);

  double hitungOngkir() {
    return 0;
  }
}

class PaketReguler extends Paket {
  PaketReguler(super.namaPengirim, super.tujuan, super.beratKg);

  @override
  double hitungOngkir() {
    return beratKg * 10000;
  }
}

class PaketKilat extends Paket {
  PaketKilat(super.namaPengirim, super.tujuan, super.beratKg);

  @override
  double hitungOngkir() {
    return (beratKg * 15000) + 5000;
  }
}

class AgenEkspedisi {
  List<Paket> daftarPaket = [];
  double _totalPendapatan = 0;

  double get totalPendapatan => _totalPendapatan;

  void terimaPaket(Paket p) {
    daftarPaket.add(p);
    _totalPendapatan += p.hitungOngkir();
    print("Paket tujuan ${p.tujuan} berhasil diterima agen!");
  }
}

void main() {
  var agenPusat = AgenEkspedisi();

  while (true) {
    print("\n=== AGEN EKSPEDISI CEPATKIRIM ===");
    print("1. Terima Paket Baru");
    print("2. Lihat Semua Paket");
    print("3. Cek Total Pendapatan Agen");
    print("4. Keluar");
    stdout.write("Pilih menu (1-4): ");

    String pilihan = stdin.readLineSync() ?? "";

    if (pilihan == "1") {
      stdout.write("Nama Pengirim: ");
      String nama = stdin.readLineSync() ?? "";

      stdout.write("Tujuan: ");
      String tujuan = stdin.readLineSync() ?? "";

      stdout.write("Berat (Kg): ");
      double berat = double.parse(stdin.readLineSync() ?? "0");

      stdout.write("Jenis Layanan (1: Reguler, 2: Kilat): ");
      String jenis = stdin.readLineSync() ?? "";

      if (jenis == "1") {
        var p = PaketReguler(nama, tujuan, berat);
        agenPusat.terimaPaket(p);
      } else if (jenis == "2") {
        var p = PaketKilat(nama, tujuan, berat);
        agenPusat.terimaPaket(p);
      } else {
        print("Pilihan layanan tidak valid!");
      }
    } else if (pilihan == "2") {
      print("\n--- DAFTAR PAKET MASUK ---");

      for (var p in agenPusat.daftarPaket) {
        print("Pengirim: ${p.namaPengirim}, Tujuan: ${p.tujuan}");
      }
    } else if (pilihan == "3") {
      print("\nTotal Pendapatan: Rp ${agenPusat.totalPendapatan}");
    } else if (pilihan == "4") {
      print("Menutup sistem... Terima kasih!");
      break;
    } else {
      print("Menu tidak tersedia!");
    }
  }
}