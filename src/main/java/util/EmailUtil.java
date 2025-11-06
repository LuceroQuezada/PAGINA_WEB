package util;

import java.io.InputStream;
import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class EmailUtil {
    
    private static Session session;

    static {
        try {
            Properties props = new Properties();
          
            InputStream in = EmailUtil.class.getClassLoader()
                        .getResourceAsStream("mail.properties");
            if (in == null) throw new RuntimeException("No cargo mail.properties!");
            props.load(in);
            
          
            props.put("mail.smtp.ssl.trust", props.getProperty("mail.smtp.host"));

          
            session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(
                        props.getProperty("mail.smtp.user"),
                        props.getProperty("mail.smtp.password")
                    );
                }
            });
           
            session.setDebug(true);
        } catch (Exception e) {
            throw new RuntimeException("No se pudo cargar mail.properties", e);
        }
    }

    public static void sendEmail(String to, String subject, String body) throws MessagingException {
        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(session.getProperty("mail.smtp.user")));
        msg.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
        msg.setSubject(subject);
        msg.setText(body);
        Transport.send(msg);
    }
}
