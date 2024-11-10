<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
    function filterByStatus() {
        var selectedStatus = document.getElementById("statusSelect").value;
        if (selectedStatus === "") {
            window.location.href = "/admin/san-pham-chi-tiet/index";
        } else {
            window.location.href = "/admin/san-pham-chi-tiet/filter?status=" + selectedStatus;
        }
    }

    function filterByColor() {
        var selectedColor = document.getElementById("colorSelect").value;
        if (selectedColor === "") {
            window.location.href = "/admin/san-pham-chi-tiet/index";
        } else {
            window.location.href = "/admin/san-pham-chi-tiet/filter-mau-sac?tenMauSac=" + selectedColor;
        }
    }

    function filterBySize() {
        var selectedSize = document.getElementById("sizeSelect").value;
        if (selectedSize === "") {
            window.location.href = "/admin/san-pham-chi-tiet/index";
        } else {
            window.location.href = "/admin/san-pham-chi-tiet/filter-kich-co?tenKichCo=" + selectedSize;
        }
    }

    function searchByName(event) {
        if (event.key === "Enter") {
            var searchQuery = document.getElementById("searchInput").value;
            window.location.href = "/admin/san-pham-chi-tiet/search?name=" + searchQuery;
        }
    }
</script>

<div>
    <h3 class="text-center mt-3">Quản Lý Sản Phẩm Chi Tiết</h3>
    <div class="row col-2 ms-1 mt-3">
        <a href="/admin/san-pham-chi-tiet/create" class="btn btn-success">Thêm sản phẩm chi tiết</a>
    </div>

    <div class="row ">
        <!-- lọc đang bán-ngừng bán -->
        <div class="col-2 ms-1 mt-3">
            <select id="statusSelect" class="form-select" aria-label="Default select example"
                    onchange="filterByStatus()">
                <option value="" ${param.status == null ? 'selected' : ''}>Tất cả</option>
                <option value="1" ${param.status == '1' ? 'selected' : ''}>Đang bán</option>
                <option value="0" ${param.status == '0' ? 'selected' : ''}>Ngừng bán</option>

            </select>
        </div>
        <!-- lọc theo màu sắc -->
        <div class="col-2 ms-1 mt-3">
            <select id="colorSelect" class="form-select" aria-label="Default select example"
                    onchange="filterByColor()">
                <option value="" ${param.ten == null ? 'selected' : ''}>Tất cả màu sắc</option>
                <c:forEach items="${listMauSac}" var="color">
                    <option value="${color.ten}" ${param.tenMauSac == color.ten ? 'selected' : ''}>
                            ${color.ten}
                    </option>
                </c:forEach>
            </select>
        </div>
        <!-- Lọc theo kích cỡ -->
        <div class="col-2 ms-1 mt-3">
            <select id="sizeSelect" class="form-select" aria-label="Default select example"
                    onchange="filterBySize()">
                <option value="" ${param.ten == null ? 'selected' : ''}>Tất cả kích cỡ</option>
                <c:forEach items="${listKichCo}" var="size">
                    <option value="${size.ten}" ${param.tenKichCo == size.ten ? 'selected' : ''}>
                            ${size.ten}
                    </option>
                </c:forEach>
            </select>
        </div>
        <!-- Tìm kiếm theo tên -->
        <div class="col-4 ms-1 mt-3">
            <input type="text" id="searchInput" class="form-control" placeholder="Tìm kiếm theo tên"
                   onkeypress="searchByName(event)">
        </div>
        <div class="ms-1">
            <table class="table table-bordered text-center mt-3">
                <thead>
                <tr>
                    <th>STT</th>
                    <th>Mã sản phẩm</th>
                    <th>Tên sản phẩm</th>
                    <th>Màu Sắc</th>
                    <th>Kích cỡ</th>
                    <th>Giá</th>
                    <th>Số lượng</th>
                    <th>Trạng thái</th>
                    <th colspan="2">Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list.content}" var="sanPhamChiTiet" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${sanPhamChiTiet.maSanPham}</td>
                        <td>${sanPhamChiTiet.tenSanPham}</td>
                        <td>${sanPhamChiTiet.tenMauSac}</td>
                        <td>${sanPhamChiTiet.tenKichCo}</td>
                        <td>
                            <fmt:formatNumber value="${sanPhamChiTiet.gia}" pattern="#,##0 vnđ"/>
                        </td>

                        <td>${sanPhamChiTiet.soLuong}</td>
                        <td>
                            <c:if test="${sanPhamChiTiet.trangThai == 1}">
                                <span class="badge bg-success">Đang bán</span>
                            </c:if>
                            <c:if test="${sanPhamChiTiet.trangThai == 0}">
                                <span class="badge bg-danger">Ngừng bán</span>
                            </c:if>
                            <c:if test="${sanPhamChiTiet.trangThai == 2}">
                                <span class="badge bg-danger">Tạm thời</span>
                            </c:if>
                        </td>
                        <td>
                            <a href="/admin/san-pham-chi-tiet/edit/${sanPhamChiTiet.id}">
                                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor"
                                     class="bi bi-pencil-fill" viewBox="0 0 16 16">
                                    <path d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.5.5 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11z"/>
                                </svg>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<div class="mt-3">
    <div class="text-center">
        <c:if test="${list.totalPages > 1}">
            <ul class="pagination">
                <li class="page-item <c:if test="${list.number == 0}">disabled</c:if>">
                    <a class="page-link" href="?page=1">First</a>
                </li>
                <c:forEach var="i" begin="1" end="${list.totalPages}">
                    <li class="page-item <c:if test="${list.number + 1 == i}">active</c:if>">
                        <a class="page-link" href="?page=${i}">${i}</a>
                    </li>
                </c:forEach>
                <li class="page-item <c:if test="${list.number == list.totalPages-1}">disabled</c:if>">
                    <a class="page-link" href="?page=${list.totalPages}">Last</a>
                </li>
            </ul>
        </c:if>
    </div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Kiểm tra thông báo thành công
        <c:if test="${not empty successMessage}">
        Swal.fire({
            position: 'center',
            icon: 'success',
            title: '${successMessage}',
            showConfirmButton: false,
            timer: 2000
        });
        </c:if>

        // Kiểm tra thông báo lỗi
        <c:if test="${not empty errorMessage}">
        Swal.fire({
            position: 'center',
            icon: 'error',
            title: '${errorMessage}',
            showConfirmButton: false,
            timer: 2000
        });
        </c:if>
    });
</script>
