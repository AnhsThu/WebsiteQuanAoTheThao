package com.example.websitebanquanao.controllers.admins;

import com.example.websitebanquanao.entities.CauLacBo;
import com.example.websitebanquanao.infrastructures.requests.CauLacBoRequest;
import com.example.websitebanquanao.infrastructures.responses.CauLacBoResponse;
import com.example.websitebanquanao.repositories.CauLacBoRepository;
import com.example.websitebanquanao.services.CauLacBoService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/cau-lac-bo")
public class CauLacBoController {
    @Autowired
    private CauLacBoService cauLacBoService;

    @Autowired
    private CauLacBoRequest cauLacBoRequest;

    private static final String redirect = "redirect:/admin/cau-lac-bo/index";
    @Autowired
    private CauLacBoRepository cauLacBoRepository;

    @GetMapping("index")
    public String index(@RequestParam(name = "page", defaultValue = "1") int page, Model model, @ModelAttribute("successMessage") String successMessage) {
        Page<CauLacBoResponse> cauLacBoPage = cauLacBoService.getPage(page, 5);
        model.addAttribute("clbPage", cauLacBoPage);
        model.addAttribute("clb", cauLacBoRequest);
        model.addAttribute("successMessage", successMessage);
        model.addAttribute("view", "/views/admin/cau-lac-bo/index.jsp");
        return "admin/layout";
    }

    @GetMapping("delete/{id}")
    public String delete(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        cauLacBoService.delete(id);
        redirectAttributes.addFlashAttribute("successMessage", "Xoá câu lạc bộ thành công");
        return redirect;
    }

    @PostMapping("store")
    public String store(@Valid @ModelAttribute("clb") CauLacBoRequest cauLacBoRequest, BindingResult result, Model model, RedirectAttributes redirectAttributes) {

        String ten = cauLacBoRequest.getTen().trim();

        if (ten.isEmpty() || !ten.equals(cauLacBoRequest.getTen())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên không hợp lệ (không được có khoảng trắng ở đầu )");
            return redirect; // Replace with your actual redirect path
        }

        if (!cauLacBoService.isTenValid(cauLacBoRequest.getTen())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên toàn khoảng trắng không hợp lệ");
            return redirect;
        }

        if (result.hasErrors()) {
            model.addAttribute("view", "/views/admin/cau-lac-bo/index.jsp");
            return "admin/layout";
        }

        if (cauLacBoRepository.existsByTen(cauLacBoRequest.getTen())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Thêm mới không thành công - Câu lạc bộ đã tồn tại");
            return redirect;
        }


        cauLacBoService.add(cauLacBoRequest);
        // Lưu thông báo thêm thành công vào session
        redirectAttributes.addFlashAttribute("successMessage", "Thêm câu lạc bộ thành công");
        return redirect;
    }

    @PostMapping("update/{id}")
    public String update(@PathVariable("id") Integer id,
                         @Valid @ModelAttribute("clb") CauLacBoRequest cauLacBoRequest,
                         BindingResult result,
                         Model model,
                         RedirectAttributes redirectAttributes) {
        CauLacBo existingCauLacBo = cauLacBoService.findById(id);
        if (existingCauLacBo == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Câu lạc bộ không tồn tại");
            return redirect;
        }
        String updatedTen = cauLacBoRequest.getTen().trim();
        if (updatedTen.isEmpty() || !updatedTen.equals(cauLacBoRequest.getTen().trim())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên không hợp lệ (không được có khoảng trắng ở đầu)");
            return redirect;
        }
        if (!cauLacBoService.isTenValid(updatedTen)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên toàn khoảng trắng không hợp lệ");
            return redirect;
        }
        if (cauLacBoRepository.existsByTen(updatedTen) && !updatedTen.equals(existingCauLacBo.getTen())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Cập nhật không thành công - Tên câu lạc bộ đã tồn tại");
            return redirect;
        }
        if (updatedTen.equals(existingCauLacBo.getTen())) {
            cauLacBoRequest.setTen(existingCauLacBo.getTen());
        }

        // Thực hiện cập nhật
        cauLacBoService.update(cauLacBoRequest, id);
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật câu lạc bộ thành công");
        return redirect;
    }


    @GetMapping("get/{id}")
    @ResponseBody
    public ResponseEntity<CauLacBoResponse> getCauLacBo(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(cauLacBoService.getById(id));
    }

}
