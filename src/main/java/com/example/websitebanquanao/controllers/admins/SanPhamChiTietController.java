package com.example.websitebanquanao.controllers.admins;

import com.example.websitebanquanao.entities.HoaDon;
import com.example.websitebanquanao.entities.HoaDonChiTiet;
import com.example.websitebanquanao.entities.SanPhamChiTiet;
import com.example.websitebanquanao.infrastructures.requests.*;
import com.example.websitebanquanao.infrastructures.responses.HoaDonChiTietUserResponse;
import com.example.websitebanquanao.infrastructures.responses.SanPhamChiTietResponse;
import com.example.websitebanquanao.repositories.SanPhamChiTietRepository;
import com.example.websitebanquanao.services.*;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.Banner;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/admin/san-pham-chi-tiet")
public class SanPhamChiTietController {

    @Autowired
    private SanPhamChiTietService sanPhamChiTietService;

    @Autowired
    private SanPhamService sanPhamService;

    @Autowired
    private MauSacService mauSacService;

    @Autowired
    private KichCoService kichCoService;

    @Autowired
    private HoaDonChiTietService hoaDonChiTietService;

    @Autowired
    private AnhSanPhamService anhSanPhamService;
    @Autowired
    private MauSacRequest mauSacRequest;
    @Autowired
    private KichCoRequest kichCoRequest;
    @Autowired
    private LoaiService loaiService;
    @Autowired
    private CauLacBoService cauLacBoService;
    @Autowired
    private ThuongHieuService thuongHieuService;
    @Autowired
    private SanPhamRequest sanPhamRequest;
    @Autowired
    HttpSession session;
    @Autowired
    private SanPhamChiTietRepository sanPhamChiTietRepository;

    @GetMapping("/index")
    public String index(Model model, @RequestParam(name = "page", defaultValue = "1") int page) {
        model.addAttribute("list", sanPhamChiTietService.getPage(page, 10));
        model.addAttribute("listMauSac", mauSacService.getAll());
        model.addAttribute("listKichCo", kichCoService.getAll());
        model.addAttribute("listCauLacBo", cauLacBoService.getAll());
        model.addAttribute("listThuongHieu", thuongHieuService.getAll());
        model.addAttribute("view", "/views/admin/san-pham-chi-tiet/index.jsp");
        return "admin/layout";
    }

    @GetMapping("/create")
    public String create(Model model) {
        List<SanPhamChiTietResponse> listtam = sanPhamChiTietService.getlisttam();
        model.addAttribute("listtam", listtam);
        model.addAttribute("listSanPham", sanPhamService.getAll());
        model.addAttribute("listMauSac", mauSacService.getAll());
        model.addAttribute("listKichCo", kichCoService.getAll());
        model.addAttribute("listCauLacBo", cauLacBoService.getAll());
        model.addAttribute("listThuongHieu", thuongHieuService.getAll());
        model.addAttribute("list", sanPhamChiTietService.getAll());
        model.addAttribute("ms", mauSacRequest);
        model.addAttribute("kc", new KichCoRequest());
        model.addAttribute("listLoai", loaiService.getAll());
        model.addAttribute("sp", sanPhamRequest);
        model.addAttribute("sanPhamChiTiet", new SanPhamChiTietRequest());
        model.addAttribute("action", "/admin/san-pham-chi-tiet/add");
        model.addAttribute("view", "/views/admin/san-pham-chi-tiet/create.jsp");
        return "admin/layout";
    }

    @GetMapping("addlist")
    public String addlist() {
        sanPhamChiTietService.updateList();
        return "redirect:/admin/san-pham-chi-tiet/index";
    }

    @PostMapping("/add")
    public String add(@ModelAttribute("sanPhamChiTiet") SanPhamChiTietRequest sanPhamChiTietRequest, RedirectAttributes redirectAttributes) {
        sanPhamChiTietRequest.setTrangThai(2);
        if (sanPhamChiTietService.add(sanPhamChiTietRequest)) {
            redirectAttributes.addFlashAttribute("successMessage", "Thêm sản phẩm chỉ tiết tạm thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Sản phẩm chi tiết đã tồn tại");
        }
        ;
        return "redirect:/admin/san-pham-chi-tiet/create";
    }


    @GetMapping("delete/{id}")
    public String delete(@PathVariable("id") UUID id) {
        sanPhamChiTietService.delete(id);
        return "redirect:/admin/san-pham-chi-tiet/create";
    }

    @PostMapping("update/{id}")
    public String update(@PathVariable("id") UUID id, @Valid @ModelAttribute("sanPhamChiTiet") SanPhamChiTietRequest sanPhamChiTietRequest, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("list", sanPhamChiTietService.getAll());
            model.addAttribute("view", "/views/admin/san-pham-chi-tiet/index.jsp");
            return "admin/layout";
        }
        sanPhamChiTietService.update(sanPhamChiTietRequest, id);
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật chi tiết sản phẩm thành công");
        return "redirect:/admin/san-pham-chi-tiet/index";
    }

    @PostMapping("updatetam/{id}")
    public String updatetam(@PathVariable("id") UUID id, @Valid @ModelAttribute("sanPhamChiTiet") SanPhamChiTietRequest sanPhamChiTietRequest, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("list", sanPhamChiTietService.getAll());
            model.addAttribute("view", "/views/admin/san-pham-chi-tiet/create.jsp");
            System.out.println("Validation errors: " + result.getAllErrors());
            return "admin/layout";
        }

        try {
            System.out.println("Updating product details with id: " + id);
            sanPhamChiTietService.updatetam(sanPhamChiTietRequest, id);
            sanPhamChiTietRequest.setTrangThai(2);
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật chi tiết sản phẩm thành công");
        } catch (Exception e) {
            System.err.println("Error updating product details: " + e.getMessage());
            model.addAttribute("list", sanPhamChiTietService.getAll());
            model.addAttribute("view", "/views/admin/san-pham-chi-tiet/create.jsp");
            model.addAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật chi tiết sản phẩm.");
            return "admin/layout";
        }

        return "redirect:/admin/san-pham-chi-tiet/create";
    }


    @GetMapping("/updatetam/{id}")
    public String updatetam(@PathVariable("id") SanPhamChiTiet sanPhamChiTiet, Model model) {
        model.addAttribute("listSanPham", sanPhamService.getAll());
        model.addAttribute("listMauSac", mauSacService.getAll());
        model.addAttribute("listKichCo", kichCoService.getAll());

        model.addAttribute("list", sanPhamChiTietService.getAll());

        model.addAttribute("sanPhamChiTiet", sanPhamChiTiet);
        model.addAttribute("action", "/admin/san-pham-chi-tiet/updatetam/" + sanPhamChiTiet.getId());
        model.addAttribute("view", "/views/admin/san-pham-chi-tiet/updatetam.jsp");
        return "admin/layout";
    }


    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") SanPhamChiTiet sanPhamChiTiet, Model model) {
        model.addAttribute("listSanPham", sanPhamService.getAll());
        model.addAttribute("listMauSac", mauSacService.getAll());
        model.addAttribute("listKichCo", kichCoService.getAll());

        model.addAttribute("list", sanPhamChiTietService.getAll());

        model.addAttribute("sanPhamChiTiet", sanPhamChiTiet);
        model.addAttribute("action", "/admin/san-pham-chi-tiet/update/" + sanPhamChiTiet.getId());
        model.addAttribute("view", "/views/admin/san-pham-chi-tiet/update.jsp");
        return "admin/layout";
    }

    @GetMapping("/get-anh/{id}")
    public String getAnh(@PathVariable("id") UUID id, Model model) {
        model.addAttribute("list", sanPhamChiTietService.getAll());
        model.addAttribute("sanPhamChiTiet", new SanPhamChiTietRequest());
        model.addAttribute("listAnh", anhSanPhamService.getAll(id));
        model.addAttribute("view", "/views/admin/san-pham-chi-tiet/create.jsp");
        return "admin/layout";
    }

    @GetMapping("/filter")
    public String filter(@RequestParam(name = "status", required = false) Integer status, Model model, @RequestParam(name = "page", defaultValue = "1") int page) {
        Page<SanPhamChiTietResponse> filteredList;

        if (status != null && status != -1) {
            filteredList = sanPhamChiTietService.getByStatus(status,page,10);
        } else {
            // If no status is selected, show all products.
            filteredList = sanPhamChiTietService.getPage(page,10);
        }
        model.addAttribute("list", sanPhamChiTietService.getAll());
        model.addAttribute("listMauSac", mauSacService.getAll());
        model.addAttribute("listKichCo", kichCoService.getAll());
        model.addAttribute("list", filteredList);
        model.addAttribute("view", "/views/admin/san-pham-chi-tiet/index.jsp");
        return "admin/layout";
    }

    @GetMapping("/filter-mau-sac")
    public String filterMauSac(@RequestParam(name = "tenMauSac", required = false) String tenMauSac, Model model, @RequestParam(name = "page", defaultValue = "1") int page) {
        Page<SanPhamChiTietResponse> filteredList;

        if (tenMauSac != null && !tenMauSac.isEmpty()) {
            filteredList = sanPhamChiTietService.getByTenMauSac(tenMauSac, page, 10);
        } else {
            // If no status is selected, show all products.
            filteredList = sanPhamChiTietService.getPage(page, 10);
        }
        model.addAttribute("list", sanPhamChiTietService.getAll());
        model.addAttribute("listMauSac", mauSacService.getAll());
        model.addAttribute("listKichCo", kichCoService.getAll());
        model.addAttribute("list", filteredList);
        model.addAttribute("view", "/views/admin/san-pham-chi-tiet/index.jsp");
        return "admin/layout";
    }

    @GetMapping("/filter-kich-co")
    public String filterKichCo(@RequestParam(name = "tenKichCo", required = false) String tenKichCo, Model model, @RequestParam(name = "page", defaultValue = "1") int page) {
        Page<SanPhamChiTietResponse> filteredList;

        if (tenKichCo != null && !tenKichCo.isEmpty()) {
            filteredList = sanPhamChiTietService.getByTenKichCo(tenKichCo, page, 10);
        } else {
            // If no status is selected, show all products.
            filteredList = sanPhamChiTietService.getPage(page, 10);
        }
        model.addAttribute("list", sanPhamChiTietService.getAll());
        model.addAttribute("listMauSac", mauSacService.getAll());
        model.addAttribute("listKichCo", kichCoService.getAll());
        model.addAttribute("list", filteredList);
        model.addAttribute("view", "/views/admin/san-pham-chi-tiet/index.jsp");
        return "admin/layout";
    }

    @PostMapping("/tra-hang-vao-kho")
    public String traHangVaoKho(@RequestParam("idHoaDon") UUID idHoaDon,
                                @RequestParam("idSanPhamChiTiet") UUID idSanPhamChiTiet,
                                @RequestParam("soLuongTraHang") int soLuongTraHang,
                                RedirectAttributes redirectAttributes) {
        if (hoaDonChiTietService.getHoaDonChiTietByHoaDonIdAndIdSanPhamChiTiet(idHoaDon, idSanPhamChiTiet).getTrangThai() == 2) {
            redirectAttributes.addFlashAttribute("errorMessage", "Sản phẩm này đã được hoàn trước đó.");
            return "redirect:/admin/hoa-don/" + idHoaDon;
        } else if (hoaDonChiTietService.getHoaDonChiTietByHoaDonIdAndIdSanPhamChiTiet(idHoaDon, idSanPhamChiTiet).getTrangThai() == 1) {
            redirectAttributes.addFlashAttribute("errorMessage", "Sản phẩm này chưa được xác nhận lấy trước đó.");
            return "redirect:/admin/hoa-don/" + idHoaDon;
        }
        try {
            // Kiểm tra trạng thái đã hoàn từ session trước khi thực hiện
            String sessionKey = "daHoan_" + idSanPhamChiTiet + "_" + idHoaDon;
            if (session.getAttribute(sessionKey) != null) {
                throw new Exception("Sản phẩm này đã được hoàn trước đó.");
            }
            // Thực hiện trả hàng vào kho
            sanPhamChiTietService.xuLyTraHangVaoKho(idSanPhamChiTiet, soLuongTraHang);
            HoaDonChiTiet hoaDonChiTiet = hoaDonChiTietService.getHoaDonChiTietByHoaDonIdAndIdSanPhamChiTiet(idHoaDon, idSanPhamChiTiet);
            hoaDonChiTiet.setTrangThai(2);
            hoaDonChiTietService.update(hoaDonChiTiet);
            // Lưu trạng thái đã hoàn vào session
            session.setAttribute(sessionKey, true);

            // Trả về view với thông điệp hoặc dữ liệu cần thiết
            redirectAttributes.addFlashAttribute("successMessage", "Trả hàng vào kho thành công.");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/admin/hoa-don/" + idHoaDon;
    }

    @GetMapping("/search")
    public String searchByName(@RequestParam("name") String tenSanPham, Model model, @RequestParam(name = "page", defaultValue = "1") int page) {
        Page<SanPhamChiTietResponse> list = sanPhamChiTietService.searchByTenSanPham(tenSanPham,page,10);
        model.addAttribute("list", list);
        model.addAttribute("listMauSac", mauSacService.getAll()); // Thêm danh sách màu sắc
        model.addAttribute("listKichCo", kichCoService.getAll()); // Thêm danh sách kích cỡ
        model.addAttribute("view", "/views/admin/san-pham-chi-tiet/index.jsp"); // Đường dẫn view
        return "admin/layout"; // Trả về layout của admin
    }


}
