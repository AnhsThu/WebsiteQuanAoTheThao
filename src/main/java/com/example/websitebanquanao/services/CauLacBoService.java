package com.example.websitebanquanao.services;

import com.example.websitebanquanao.entities.CauLacBo;
import com.example.websitebanquanao.entities.ThuongHieu;
import com.example.websitebanquanao.infrastructures.requests.CauLacBoRequest;
import com.example.websitebanquanao.infrastructures.responses.CauLacBoResponse;
import com.example.websitebanquanao.repositories.CauLacBoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class CauLacBoService {
    @Autowired
    private CauLacBoRepository cauLacBoRepository;

    // admin

    public List<CauLacBoResponse> getAll() {
        return cauLacBoRepository.getAll();
    }

    public Page<CauLacBoResponse> getPage(int page, int pageSize) {
        Pageable pageable = PageRequest.of(page - 1, pageSize);
        return cauLacBoRepository.getPage(pageable);
    }

    public void add(CauLacBoRequest cauLacBoRequest) {
        CauLacBo cauLacBo  = new CauLacBo();
        cauLacBo.setTen(cauLacBoRequest.getTen());

        java.util.Date currentDate = new java.util.Date();

        // Thiết lập ngày tạo là ngày hiện tại nếu chưa có, chuyển đổi sang java.sql.Date
        if (cauLacBoRequest.getNgay_tao() == null) {
            cauLacBo.setNgay_tao(new java.sql.Date(currentDate.getTime()));
        } else {
            cauLacBo.setNgay_tao(cauLacBoRequest.getNgay_tao());
        }

        // Thiết lập ngày sửa là ngày hiện tại, chuyển đổi sang java.sql.Date
        cauLacBo.setNgay_sua(new java.sql.Date(currentDate.getTime()));


        cauLacBo.setTrang_thai(cauLacBoRequest.getTrang_thai());

        // Lưu đối tượng thương hiệu vào cơ sở dữ liệu
        cauLacBoRepository.save(cauLacBo);
        System.out.println("ThuongHieuService.add: " + cauLacBo.getTen());
    }


    public void update(CauLacBoRequest  cauLacBoRequest, Integer id){
        CauLacBo cauLacBo = cauLacBoRepository.findById(id).orElse(null);
        if (cauLacBo != null){
            cauLacBo.setTen(cauLacBoRequest.getTen());
            cauLacBo.setTrang_thai(cauLacBoRequest.getTrang_thai());
            java.util.Date currentDate = new java.util.Date();
            cauLacBo.setNgay_sua(new java.sql.Date(currentDate.getTime()));

            cauLacBoRepository.save(cauLacBo);
            System.out.println("cauLacBoService.update: " + cauLacBo.getTen());
        } else {
            System.out.println("cauLacBoService.update: null");
        }
    }


    public void delete(int id) {
        CauLacBo thuongHieu = cauLacBoRepository.findById(id).orElse(null);
        if (thuongHieu != null) {
            cauLacBoRepository.deleteById(id);

            System.out.println("cauLacBoService.delete: " + id);
        } else {
            System.out.println("cauLacBoService.delete: null");
        }
    }

    public CauLacBoResponse getById(Integer id) {
        CauLacBoResponse thuongHieuResponse = cauLacBoRepository.getByIdResponse(id);
        if (thuongHieuResponse != null) {
            System.out.println("cauLacBo.getById: " + thuongHieuResponse.getTen());
            return thuongHieuResponse;
        } else {
            System.out.println("cauLacBo.getById: null");
            return null;
        }
    }

    public boolean isTenValid(String ten) {
        return ten != null && !ten.trim().isEmpty(); }

    public CauLacBo findById(Integer id) {
        return cauLacBoRepository.findById(id).orElse(null);
    }

}
