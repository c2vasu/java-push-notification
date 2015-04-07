package ca.spring.mvc.push.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author SrinivasaRao
 *
 */
@Controller
public class NotificationController {

	@RequestMapping("/index")
	public String index() {
		return "index";
	}
}
