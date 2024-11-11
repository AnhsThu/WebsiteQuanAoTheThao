<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<div class="container mt-3">
    <h1 class="text-center">Quản Lý Màu Sắc</h1>


    <div class="row mt-3">
        <div class="col-9">
            <table class="table table-bordered mt-3 text-center">
                <thead>
                <tr>
                    <th>STT</th>
                    <th>Tên Màu</th>
                    <th>Trạng  Thái</th>
                    <th>Thao Tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach varStatus="index" items="${mauSacPage.content}" var="ms">
                    <tr>
                        <td>${index.index + mauSacPage.number * mauSacPage.size + 1}</td>
                        <td>${ms.ten}</td>
                        <td>
                            <c:if test="${ms.trang_thai == 1}">
                                <span class="badge bg-success">Còn hàng</span>
                            </c:if>
                            <c:if test="${ms.trang_thai == 0}">
                                <span class="badge bg-danger">Hết hàng</span>
                            </c:if>
                        </td>
                        <td>
                            <a href="#" class=" update-button"
                               data-bs-toggle="modal" data-bs-target="#exampleModal"
                               data-id="${ms.id}" data-ten="${ms.ten}" data-trang_thai="${ms.trang_thai}">
                                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-pencil-fill" viewBox="0 0 16 16">
                                    <path d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.5.5 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11z"/>
                                </svg>
                            </a>
                                <%--                            <a href="/admin/mau-sac/delete/${ms.id}" class="btn btn-danger"--%>
                                <%--                               onclick="return confirm('Bạn có chắc chắn muốn xoá không?')">Xoá</a>--%>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="col-3 mt-4">
            <form:form id="edit-form" modelAttribute="ms" method="post" action="/admin/mau-sac/store">
                <div class="form-group text-center">
                    <label for="ten" class="form-label">Tên Màu</label>
                    <form:input type="text" path="ten" id="ten" class="form-control"/> <br>
                    <form:select path="trang_thai" id="trang_thai" class="form-select form-select-sm" aria-label="Small select example" >
                        <option value="1">Còn hàng</option>
                        <option value="0">Hết hàng</option>
                    </form:select>
                    <button type="submit" class="btn btn-success mt-3">Lưu</button>
                </div>
            </form:form>
        </div>
    </div>

    <div class="mt-3">
        <div class="text-center">
            <c:if test="${mauSacPage.totalPages > 1}">
                <ul class="pagination">
                    <li class="page-item <c:if test="${mauSacPage.number == 0}">disabled</c:if>">
                        <a class="page-link" href="?page=1">First</a>
                    </li>
                    <c:forEach var="i" begin="1" end="${mauSacPage.totalPages}">
                        <li class="page-item <c:if test="${mauSacPage.number + 1 == i}">active</c:if>">
                            <a class="page-link" href="?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item <c:if test="${mauSacPage.number == mauSacPage.totalPages}">disabled</c:if>">
                        <a class="page-link" href="?page=${mauSacPage.totalPages}">Last</a>
                    </li>
                </ul>
            </c:if>
        </div>
    </div>
</div>


<!-- Bao gồm các tập lệnh Spring form và các tập lệnh khác -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(".update-button").click(function () {
        let id = $(this).data("id");

        // Thực hiện yêu cầu AJAX để lấy dữ liệu khách hàng dựa trên id
        $.ajax({
            url: "/admin/mau-sac/get/" + id,
            type: "GET",
            success: function (data) {
                $("#ten").val(data.ten);
                $("#trang_thai").val(data.trang_thai);
                $("#edit-form").attr("action", "/admin/mau-sac/update/" + id);
            },
            error: function (error) {
                console.error("Error:", error);
            },
        });
    });
    document.addEventListener("DOMContentLoaded", function () {
        var updateButtons = document.querySelectorAll(".update-button");
        var clickClose = document.querySelector(".btn-close");

        updateButtons.forEach(function (button) {
            button.addEventListener("click", function () {
                var modalTitle = document.querySelector(".modal-title");

                modalTitle.textContent = "Cập Nhật Màu Sắc";

            });
        });
        clickClose.addEventListener("click", function () {
            var modalTitle = document.querySelector(".modal-title");

            modalTitle.textContent = "Thêm Màu Sắc";

            $("#edit-form").trigger("reset");
            $("#edit-form").attr("action", "/admin/mau-sac/store");

        });
    });
    $(document).ready(function () {
        hideErrorMessage();
        hideErrorMessage2();
    });

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
</body>
</html>