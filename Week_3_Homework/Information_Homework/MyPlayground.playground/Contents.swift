import UIKit

/*
 
 1 ) FRAME VE BOUND ARASINDAKİ FARK
 
 FRAME = Ana görünümün koordinat sistemini kullanarak bir görünümün konumu ve boyutu
 ayarlamak için kullanılır.

 Şunlar için önemlidir: Görünümü üst öğeye yerleştirme.

 BOUNDS = Kendi koordinat sistemini kullanan bir görünümün konumu ve boyutu ayarlamak
 için kullanılır.

 Şunlar için önemlidir: görünümün içeriğini veya alt görünümlerini kendi içine yerleştirme
 
 
 2 ) Yaşam döngüsü
  -viewDidLoad: Oluşturulan controllerda ilk çağırılan fonksiyondur.
  -viewWillAppear: Controller tekrar ekrana getirildiğinde çalışan fonksiyondur.
  -viewDidAppear: Controller ekrana getirildikten sonra will appeardan sonra çalışan fonksiyondur.
  -viewWillDissapear: Controller hiyerarşiden kaldırılmadan hemen önce çalışır unsubscribe işlemleri burada yapılabilir.
  -viewDidDissapear: Controller hiyerarşiden kaldırıldıktan sonra çalışır.
 */
