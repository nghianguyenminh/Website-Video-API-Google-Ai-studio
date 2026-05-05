package com.j4.util;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailService {
	private static final String HOST_NAME = "smtp.gmail.com";
    private static final String SSL_PORT = "465";
    private static final String APP_EMAIL = "vannen432@gmail.com"; 
    private static final String APP_PASSWORD = "wowa rcjw wmfx rynd"; 

    public static void send(String to, String subject, String body) throws Exception {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.host", HOST_NAME);
        props.put("mail.smtp.socketFactory.port", SSL_PORT);
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.port", SSL_PORT);

        Session session = Session.getDefaultInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(APP_EMAIL, APP_PASSWORD);
            }
        });

        MimeMessage message = new MimeMessage(session);
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(subject, "utf-8");
        message.setContent(body, "text/html; charset=utf-8");

        Transport.send(message);
    }
}
