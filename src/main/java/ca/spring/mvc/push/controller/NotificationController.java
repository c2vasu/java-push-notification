package ca.spring.mvc.push.controller;

import java.util.Random;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author SrinivasaRao
 *
 */
@Controller
public class NotificationController {
	/**
	 * For index page
	 * @return view
	 */
	@RequestMapping("/index")
	public String index() {
		return "index";
	}
	
	/**
	 * Push Notification
	 * @param response
	 * @return
	 */
	@RequestMapping("/push")
    public @ResponseBody String sendMessage(HttpServletResponse response) {
            Random r = new Random();
            response.setContentType("text/event-stream");
            try {
                    Thread.sleep(10000);
            } catch (InterruptedException e) {
                    e.printStackTrace();
            }   
            return "data:Testing 1,2,3" + r.nextInt() +"\n\n";
    }
}
