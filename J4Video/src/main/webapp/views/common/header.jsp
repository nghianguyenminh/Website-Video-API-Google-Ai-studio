<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<nav class="navbar navbar-expand-lg fixed-top navbar-vanlo">
    <div class="container">
        <a class="navbar-brand brand-title" href="/J4Video/home">
            <i class="fas fa-dragon"></i> Vân Lộ
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#vanloNav">
            <span class="navbar-toggler-icon" style="filter: invert(1);"></span>
        </button>

        <div class="collapse navbar-collapse" id="vanloNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 align-items-center">
                <li class="nav-item">
                    <a class="nav-link" href="/J4Video/home">Trang Chủ</a>
                </li>
                
                <li class="nav-item dropdown">
				    <a class="nav-link category dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
				        Thể Loại
				    </a>
				    <ul class="dropdown-menu dropdown-menu-vanlo">
				        <c:forEach items="${categories}" var="cat">
				            <li>
				                <a class="dropdown-item" href="/J4Video/home?category=${cat.code}">
				                    ${cat.name}
				                </a>
				            </li>
				        </c:forEach>
				        
				        <c:if test="${empty categories}">
				            <li><span class="dropdown-item text-muted">Đang cập nhật...</span></li>
				        </c:if>
				
				        <li><hr class="dropdown-divider"></li>
				        <li><a class="dropdown-item text-warning" href="/J4Video/home">Xem Tất Cả <i class="fas fa-arrow-right"></i></a></li>
				    </ul>
				</li>

				<li class="nav-item">
				    <a class="nav-link" href="${pageContext.request.contextPath}/schedule">Lịch Chiếu</a>
				</li>
                
                <li class="nav-item">
                    <a class="nav-link" href="/J4Video/favorites">Kho Tàng</a>
                </li>
            </ul>

            <div class="d-flex align-items-center">
                
                <form class="search-form me-4 position-relative" id="mainSearchForm" role="search" action="/J4Video/home" method="get">
				    <i class="fas fa-search search-icon-btn" onclick="document.getElementById('mainSearchForm').submit();" style="cursor: pointer;"></i>
				    <input class="search-input" type="search" name="keyword" id="mainSearchInput" 
				           value="${keyword}" 
				           placeholder="Tìm kiếm công pháp..." aria-label="Search" style="padding-right: 40px;">
				           
				    <button type="button" id="microphoneButton" class="btn btn-link position-absolute" 
				            style="right: 5px; top: 50%; transform: translateY(-50%); color: #FFB038; padding: 0;">
				        <i class="fas fa-microphone"></i>
				    </button>
				</form>
                <div class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle user-pill d-flex align-items-center" href="#" role="button" data-bs-toggle="dropdown">
                        <c:if test="${empty sessionScope.user}">
                            <i class="fas fa-user-circle fa-lg me-2"></i> Tài Khoản
                        </c:if>
                        <c:if test="${not empty sessionScope.user}">
                            <img src="https://ui-avatars.com/api/?name=${sessionScope.user.fullName}&background=f39c12&color=fff" 
                                 alt="Avatar" class="rounded-circle me-2" style="width: 25px; height: 25px;">
                            <span class="d-none d-sm-inline">${sessionScope.user.fullName}</span>
                        </c:if>
                    </a>
                    
                    <ul class="dropdown-menu dropdown-menu-vanlo dropdown-menu-end">
                        <c:if test="${sessionScope.user == null}">
                            <li><a class="dropdown-item" href="/J4Video/login"><i class="fas fa-sign-in-alt me-2"></i> Đăng Nhập</a></li>
                            <li><a class="dropdown-item" href="/J4Video/register"><i class="fas fa-user-plus me-2"></i> Đăng Ký</a></li>
                        </c:if>
                        <c:if test="${sessionScope.user != null}">
                            <li><h6 class="dropdown-header text-muted">Xin chào, ${sessionScope.user.fullName}</h6></li>
                            <li><a class="dropdown-item" href="/J4Video/profile"><i class="fas fa-id-card me-2"></i> Hồ Sơ Cá Nhân</a></li>
                            <li><a class="dropdown-item" href="/J4Video/favorites"><i class="fas fa-heart me-2"></i> Phim Yêu Thích</a></li>
                            
                            <c:if test="${sessionScope.user.admin}">
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-warning" href="/J4Video/admin/videos"><i class="fas fa-tools me-2"></i> Trang Quản Trị</a></li>
                            </c:if>
                            
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger" href="/J4Video/logout"><i class="fas fa-sign-out-alt me-2"></i> Đăng Xuất</a></li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>

<style>
    /* Nút mở chat */
    .chat-widget-btn {
        position: fixed;
        bottom: 30px;
        right: 30px;
        width: 60px;
        height: 60px;
        background: linear-gradient(135deg, #FFB038, #FF5722);
        border-radius: 50%;
        color: white;
        border: none;
        font-size: 28px;
        box-shadow: 0 4px 15px rgba(255, 87, 34, 0.4);
        cursor: pointer;
        z-index: 9999;
        transition: transform 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .chat-widget-btn:hover { transform: scale(1.1) rotate(10deg); }

    /* Khung chat chính */
    .chat-container {
        position: fixed;
        bottom: 100px;
        right: 30px;
        width: 380px;
        height: 550px;
        background: #1e1e1e;
        border-radius: 20px;
        box-shadow: 0 10px 40px rgba(0,0,0,0.5);
        display: flex;
        flex-direction: column;
        z-index: 9999;
        overflow: hidden;
        border: 1px solid #333;
        transform-origin: bottom right;
        transition: all 0.3s ease;
        opacity: 0;
        transform: scale(0);
        pointer-events: none; /* Ẩn đi thì không bấm được */
    }
    
    /* Class để hiện chat lên */
    .chat-container.active {
        opacity: 1;
        transform: scale(1);
        pointer-events: all;
    }

    /* Header */
    .chat-header {
        background: linear-gradient(to right, #2c3e50, #000);
        padding: 15px 20px;
        border-bottom: 1px solid #333;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .chat-title { color: #FFB038; font-weight: bold; font-family: 'Segoe UI', sans-serif; }
    .chat-close { background: none; border: none; color: #888; cursor: pointer; font-size: 18px; }
    
    /* Body */
    .chat-body {
        flex: 1;
        padding: 20px;
        overflow-y: auto;
        background: #121212;
        display: flex;
        flex-direction: column;
        gap: 15px;
    }

    /* Bong bóng chat */
    .msg {
        max-width: 80%;
        padding: 10px 15px;
        border-radius: 15px;
        font-size: 14px;
        line-height: 1.5;
        position: relative;
        word-wrap: break-word;
    }
    .msg-bot {
        align-self: flex-start;
        background: #333;
        color: #e0e0e0;
        border-bottom-left-radius: 2px;
    }
    .msg-user {
        align-self: flex-end;
        background: #FFB038;
        color: #000;
        font-weight: 500;
        border-bottom-right-radius: 2px;
    }

    /* Footer nhập liệu */
    .chat-footer {
        padding: 15px;
        background: #1e1e1e;
        border-top: 1px solid #333;
        display: flex;
        gap: 10px;
    }
    .chat-input {
        flex: 1;
        background: #2c2c2c;
        border: 1px solid #444;
        color: white;
        padding: 10px 15px;
        border-radius: 25px;
        outline: none;
    }
    .chat-send {
        background: #FFB038;
        border: none;
        width: 40px;
        height: 40px;
        border-radius: 50%;
        cursor: pointer;
        color: black;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    /* Hiệu ứng loading 3 chấm */
    .typing-indicator span {
        display: inline-block;
        width: 6px;
        height: 6px;
        background-color: #aaa;
        border-radius: 50%;
        animation: typing 1s infinite;
        margin: 0 2px;
    }
    .typing-indicator span:nth-child(2) { animation-delay: 0.2s; }
    .typing-indicator span:nth-child(3) { animation-delay: 0.4s; }
    @keyframes typing { 0%, 100% { transform: translateY(0); } 50% { transform: translateY(-5px); } }
</style>

<button class="chat-widget-btn" onclick="toggleChat()">
    <i class="fas fa-comment-dots"></i>
</button>

<div class="chat-container" id="chatBox">
    <div class="chat-header">
        <div class="chat-title"><i class="fas fa-robot me-2"></i>Tiểu Vân (AI)</div>
        <button class="chat-close" onclick="toggleChat()"><i class="fas fa-times"></i></button>
    </div>
    
    <div class="chat-body" id="chatBody">
        <div class="msg msg-bot">
            Tại hạ là Tiểu Vân. Đạo hữu cần tìm phim gì cứ nói, tại hạ sẽ lục tung Tàng Kinh Các để tìm! 🙏
        </div>
    </div>
    
    <div class="chat-footer">
        <input type="text" class="chat-input" id="chatInput" placeholder="Nhập câu hỏi..." onkeypress="handleEnter(event)">
        <button class="chat-send" onclick="sendMessage()"><i class="fas fa-paper-plane"></i></button>
    </div>
</div>

<script>
    
    const CHAT_STORAGE_KEY = 'tieu_van_history';
    const CHAT_BODY_ID = 'chatBody';  
    const CHAT_INPUT_ID = 'chatInput';

   
    document.addEventListener("DOMContentLoaded", function() {
        loadChatHistory();
    });

  
    function toggleChat() {
        const chatBox = document.getElementById('chatBox');
        chatBox.classList.toggle('active');
        
       // focus chout thang vao o input
        if (chatBox.classList.contains('active')) {
            document.getElementById(CHAT_INPUT_ID).focus();
            scrollToBottom();
        }
    }

  
    function handleEnter(e) {
        if (e.key === 'Enter') {
            sendMessage();
        }
    }

   
    function appendMessageToUI(sender, message) {
        let chatBox = document.getElementById(CHAT_BODY_ID);
        
        let msgDiv = document.createElement("div");
        msgDiv.className = sender === "user" ? "msg msg-user" : "msg msg-bot";
        msgDiv.innerHTML = message.replace(/\n/g, '<br>'); 
        
        chatBox.appendChild(msgDiv);
        scrollToBottom();
    }

    function scrollToBottom() {
        let chatBox = document.getElementById(CHAT_BODY_ID);
        chatBox.scrollTop = chatBox.scrollHeight;
    }

    function saveMessageToStorage(sender, message) {
        let history = JSON.parse(sessionStorage.getItem(CHAT_STORAGE_KEY)) || [];
        history.push({ sender: sender, text: message });
        sessionStorage.setItem(CHAT_STORAGE_KEY, JSON.stringify(history));
    }

    function loadChatHistory() {
        let history = JSON.parse(sessionStorage.getItem(CHAT_STORAGE_KEY)) || [];
        if (history.length > 0) {
            document.getElementById(CHAT_BODY_ID).innerHTML = ""; 
            history.forEach(item => {
                appendMessageToUI(item.sender, item.text);
            });
        }
    }

    async function sendMessage() {
        let inputField = document.getElementById(CHAT_INPUT_ID);
        let message = inputField.value.trim();
        
        if (message === "") return;

        appendMessageToUI("user", message);
        saveMessageToStorage("user", message);
        inputField.value = ""; 

        let chatBox = document.getElementById(CHAT_BODY_ID);
        let loadingDiv = document.createElement("div");
        loadingDiv.className = "msg msg-bot typing-indicator";
        loadingDiv.id = "loading-dots";
        loadingDiv.innerHTML = "<span></span><span></span><span></span>";
        chatBox.appendChild(loadingDiv);
        scrollToBottom();

        try {
            const response = await fetch("/J4Video/api/chat", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ message: message })
            });

            const data = await response.json();
            
            let loadingElement = document.getElementById("loading-dots");
            if(loadingElement) loadingElement.remove();

            if (data.response) {
			    appendMessageToUI("bot", data.response);
			    saveMessageToStorage("bot", data.response);
			} else {
			    appendMessageToUI("bot", "Tiểu Vân đang tẩu hỏa nhập ma, đạo hữu chờ chút nhé!");
			}

        } catch (error) {
            console.error("Lỗi:", error);
            let loadingElement = document.getElementById("loading-dots");
            if(loadingElement) loadingElement.remove();
            
            let errorMsg = "Tiểu Vân đang bận tu luyện, đạo hữu thử lại sau nhé!";
            appendMessageToUI("bot", errorMsg);
        }
    }
    
    function clearChatHistory() {
        sessionStorage.removeItem(CHAT_STORAGE_KEY);
        document.getElementById(CHAT_BODY_ID).innerHTML = 
            '<div class="msg msg-bot">Tại hạ là Tiểu Vân. Đạo hữu cần tìm phim gì cứ nói! 🙏</div>';
    }
</script>

<style>
    /* CSS cho Voice Search Modal */
    .voice-search-overlay {
        position: fixed; top: 0; left: 0; width: 100%; height: 100%;
        background: rgba(0, 0, 0, 0.85);
        z-index: 10000;
        display: flex; flex-direction: column; align-items: center; justify-content: center;
        opacity: 0; pointer-events: none; transition: opacity 0.3s ease;
    }
    .voice-search-overlay.active { opacity: 1; pointer-events: all; }
    
    .voice-close-btn {
        position: absolute; top: 30px; right: 40px;
        background: none; border: none; color: white; font-size: 30px; cursor: pointer;
    }
    .voice-title { color: white; font-size: 24px; margin-bottom: 40px; font-weight: 300; }
    
    .mic-circle {
        width: 100px; height: 100px; border-radius: 50%;
        background: #f39c12; color: white; font-size: 40px;
        display: flex; align-items: center; justify-content: center;
        box-shadow: 0 0 0 0 rgba(243, 156, 18, 0.5);
        animation: pulse-mic 1.5s infinite;
    }
    @keyframes pulse-mic {
        0% { transform: scale(0.95); box-shadow: 0 0 0 0 rgba(243, 156, 18, 0.7); }
        70% { transform: scale(1); box-shadow: 0 0 0 30px rgba(243, 156, 18, 0); }
        100% { transform: scale(0.95); box-shadow: 0 0 0 0 rgba(243, 156, 18, 0); }
    }
</style>

<div class="voice-search-overlay" id="voiceSearchModal">
    <button class="voice-close-btn" onclick="closeVoiceSearch()"><i class="fas fa-times"></i></button>
    <div class="voice-title" id="voiceStatusText">Đang nghe... Vui lòng nói tên phim</div>
    <div class="mic-circle"><i class="fas fa-microphone"></i></div>
</div>

<script>
    // JS xử lý riêng cho chức năng Nhận diện giọng nói
    const SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
    let recognition;

    if (SpeechRecognition) {
        recognition = new SpeechRecognition();
        recognition.lang = 'vi-VN'; // Bắt buộc tiếng Việt
        recognition.interimResults = false; 
        recognition.maxAlternatives = 1;

        // Bắt sự kiện click vào icon Micro trên thanh tìm kiếm
        document.getElementById('microphoneButton').addEventListener('click', function() {
            document.getElementById('voiceSearchModal').classList.add('active');
            document.getElementById('voiceStatusText').innerText = "Đang nghe... Vui lòng nói tên phim";
            recognition.start(); 
        });

        recognition.onresult = async function(event) {
            const transcript = event.results[0][0].transcript;
            document.getElementById('voiceStatusText').innerText = "Đang xử lý: '" + transcript + "'...";
            
            try {
                // Gọi tới Servlet API Voice Search
                const response = await fetch("${pageContext.request.contextPath}/api/voice-search", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({ transcript: transcript })
                });

                const data = await response.json();
                
                if (data.keyword && data.keyword.trim() !== "") {
                    closeVoiceSearch();
                    // Điền kết quả trả về vào ô input
                    document.getElementById('mainSearchInput').value = data.keyword;
                    // Tự động submit form để tìm kiếm
                    document.getElementById('mainSearchForm').submit();
                } else {
                    document.getElementById('voiceStatusText').innerText = "Không tìm thấy kết quả. Vui lòng thử lại!";
                    setTimeout(closeVoiceSearch, 2000);
                }

            } catch (error) {
                console.error("Lỗi AI Voice Search:", error);
                document.getElementById('voiceStatusText').innerText = "Lỗi kết nối AI!";
                setTimeout(closeVoiceSearch, 2000);
            }
        };

        recognition.onspeechend = function() {
            recognition.stop();
        };

        recognition.onerror = function(event) {
            document.getElementById('voiceStatusText').innerText = "Lỗi Micro: " + event.error;
            setTimeout(closeVoiceSearch, 2000);
        };

    } else {
        document.getElementById('microphoneButton').addEventListener('click', function() {
            alert("Trình duyệt của bạn không hỗ trợ tìm kiếm bằng giọng nói!");
        });
    }

    function closeVoiceSearch() {
        document.getElementById('voiceSearchModal').classList.remove('active');
        if(recognition) recognition.stop();
    }
</script>