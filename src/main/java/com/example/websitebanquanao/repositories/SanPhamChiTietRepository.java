package com.example.websitebanquanao.repositories;

import com.example.websitebanquanao.entities.SanPhamChiTiet;
import com.example.websitebanquanao.infrastructures.responses.BanHangTaiQuayResponse;
import com.example.websitebanquanao.infrastructures.responses.SanPhamChiTietResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface SanPhamChiTietRepository extends JpaRepository<SanPhamChiTiet, UUID> {

    @Query("select new com.example.websitebanquanao.infrastructures.responses.SanPhamChiTietResponse(s.id, s.maSanPham, s.idSanPham.id, s.idSanPham.ten, s.idMauSac.ten, s.idKichCo.ten, s.gia, s.soLuong, s.moTa, s.trangThai, s.ngay_sua, s.ngay_tao) from SanPhamChiTiet s where s.idSanPham.ten like %:tenSanPham% ORDER BY CASE WHEN s.trangThai = 1 THEN 0 ELSE 1 END")
    public Page<SanPhamChiTietResponse> getByTenSanPham(@Param("tenSanPham") String tenSanPham, Pageable pageable);

    @Query("select new com.example.websitebanquanao.infrastructures.responses.SanPhamChiTietResponse(s.id, s.maSanPham,s.idSanPham.id, s.idSanPham.ten, s.idMauSac.ten, s.idKichCo.ten, s.gia, s.soLuong, s.moTa, s.trangThai, s.ngay_sua, s.ngay_tao)  from SanPhamChiTiet s where s.trangThai = 1 ORDER BY s.idSanPham.ten desc")
    public List<SanPhamChiTietResponse> getAll();

    @Query("select new com.example.websitebanquanao.infrastructures.responses.SanPhamChiTietResponse(s.id, s.maSanPham,s.idSanPham.id, s.idSanPham.ten, s.idMauSac.ten, s.idKichCo.ten, s.gia, s.soLuong, s.moTa, s.trangThai, s.ngay_sua, s.ngay_tao)  from SanPhamChiTiet s ORDER BY CASE WHEN s.trangThai = 1 THEN 0 ELSE 1 END, s.idSanPham.ten desc ")
    public Page<SanPhamChiTietResponse> getPage(Pageable pageable);

    @Query("select new com.example.websitebanquanao.infrastructures.responses.SanPhamChiTietResponse(s.id, s.maSanPham,s.idSanPham.id, s.idSanPham.ten, s.idMauSac.ten, s.idKichCo.ten, s.gia, s.soLuong, s.moTa, s.trangThai, s.ngay_sua, s.ngay_tao)  from SanPhamChiTiet s where s.trangThai = 2 ORDER BY s.idSanPham.ten")
    public List<SanPhamChiTietResponse> Getlisttam();

    @Query("select new com.example.websitebanquanao.infrastructures.responses.BanHangTaiQuayResponse(s.id, s.idSanPham, s.idMauSac, s.idKichCo, s.gia, s.soLuong, s.moTa, s.trangThai) from SanPhamChiTiet s where s.trangThai = 1")
    public List<BanHangTaiQuayResponse> findAllCtsp();

    @Query("select new com.example.websitebanquanao.infrastructures.responses.SanPhamChiTietResponse(s.id, s.maSanPham,s.idSanPham.id, s.idSanPham.ten, s.idMauSac.ten, s.idKichCo.ten, s.gia, s.soLuong, s.moTa, s.trangThai,s.ngay_sua,s.ngay_tao) from SanPhamChiTiet s where s.trangThai = :trangThai")
    public Page<SanPhamChiTietResponse> getByStatus(@Param("trangThai") Integer trangThai,Pageable pageable);

    @Query("select new com.example.websitebanquanao.infrastructures.responses.SanPhamChiTietResponse(s.id, s.maSanPham,s.idSanPham.id, s.idSanPham.ten, s.idMauSac.ten, s.idKichCo.ten, s.gia, s.soLuong, s.moTa, s.trangThai,s.ngay_sua,s.ngay_tao) from SanPhamChiTiet s where s.idMauSac.ten = :tenMauSac ORDER BY CASE WHEN s.trangThai = 1 THEN 0 ELSE 1 END")
    public Page<SanPhamChiTietResponse> getByTenMauSac(@Param("tenMauSac") String tenMauSac,Pageable pageable);

    @Query("select new com.example.websitebanquanao.infrastructures.responses.SanPhamChiTietResponse(s.id, s.maSanPham,s.idSanPham.id, s.idSanPham.ten, s.idMauSac.ten, s.idKichCo.ten, s.gia, s.soLuong, s.moTa, s.trangThai,s.ngay_sua,s.ngay_tao) from SanPhamChiTiet s where s.idKichCo.ten = :tenKichCo ORDER BY CASE WHEN s.trangThai = 1 THEN 0 ELSE 1 END")
    public Page<SanPhamChiTietResponse> getByTenKichCo(@Param("tenKichCo") String tenKichCo,Pageable pageable);

    @Query("select spct from SanPhamChiTiet spct where spct.idSanPham.id = :idSanPham")
    public List<SanPhamChiTiet> findSanPhamChiTietByIdSanPham(@Param("idSanPham") UUID idSanPham);

    @Modifying
    @Query("UPDATE SanPhamChiTiet ctsp SET ctsp.soLuong = :currentSoLuong WHERE ctsp.id = :idSanPhamChiTiet")
    public void updateSoLuongAfterDelete(@Param("idSanPhamChiTiet") UUID idSanPhamChiTiet, @Param("currentSoLuong") int currentSoLuong);

    // get số lượng sản phẩm chi tiết theo id sản phẩm
    @Query("select s.soLuong from SanPhamChiTiet s where s.id = :idSanPham")
    public Integer getSoLuongSanPhamChiTietByIdSanPham(@Param("idSanPham") UUID idSanPham);
    // user
    @Query("select s from SanPhamChiTiet s where s.idSanPham.id = :idSanPham and s.idMauSac.id = :idMauSac and s.idKichCo.id = :idKichCo")
    public SanPhamChiTiet getByIdSanPhamAndIdMauSacAndIdKichCo(@Param("idSanPham") UUID idSanPham, @Param("idMauSac") Integer idMauSac, @Param("idKichCo") Integer idKichCo);

    @Query("select new com.example.websitebanquanao.infrastructures.responses.BanHangTaiQuayResponse(s.id, s.idSanPham, s.idMauSac, s.idKichCo, s.gia, s.soLuong, s.moTa, s.trangThai) from SanPhamChiTiet s where s.idMauSac.id = :idMauSac or s.idKichCo.id = :idKichCo or s.idSanPham.ten like %:searchTerm%")
    List<BanHangTaiQuayResponse> filterProducts(@Param("idMauSac") String idMauSac, @Param("idKichCo") String idKichCo, @Param("searchTerm") String searchTerm);

    @Query("select s from SanPhamChiTiet s where s.maSanPham = :maSanPham")
    SanPhamChiTiet findByMaSanPham(@Param("maSanPham") String maSanPham);

    @Query("select s.soLuong from SanPhamChiTiet s where s.idSanPham.id = :idSanPham and s.idMauSac.id = :idMauSac and s.idKichCo.id = :idKichCo")
    public Integer getSoLuongSanPham(@Param("idSanPham") UUID idSanPham, @Param("idMauSac") Integer idMauSac, @Param("idKichCo") Integer idKichCo);
    @Modifying
    @Query("UPDATE SanPhamChiTiet ctsp SET ctsp.trangThai = :currentTrangthai WHERE ctsp.id = :idSanPhamChiTiet")
    public void updateTrangThai(@Param("idSanPhamChiTiet") UUID idSanPhamChiTiet, @Param("currentTrangthai") int currentTrangthai);

    @Query("SELECT CASE WHEN COUNT(sp) > 0 THEN TRUE ELSE FALSE END FROM SanPhamChiTiet sp WHERE sp.idSanPham.id = :idSanPham AND sp.idMauSac.id = :idMauSac AND sp.idKichCo.id = :idKichCo")
    boolean checkTrung(@Param("idSanPham") UUID idSanPham, @Param("idMauSac") Integer idMauSac, @Param("idKichCo") Integer idKichCo);

}