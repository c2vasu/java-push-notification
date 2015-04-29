package ca.spring.mvc.push.controller;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import ca.spring.mvc.push.model.Quote;

/**
 * @author SrinivasaRao
 *
 */

@Controller
public class PushController {

	@Autowired
	SimpMessagingTemplate simpMessagingTemplate;
	
	@RequestMapping("/http")
    public String http() {
        return "http";
    }
    
    @RequestMapping("/eventsource")
    public String eventsource() {
        return "eventsource";
    }
    
    @RequestMapping("/start")
    public String start() {
        return "start";
    }
    
    @RequestMapping("/websocket")
    public String websocket() {
        return "websocket";
    }
    
    @RequestMapping("/index")
    public String index() {
        return "index";
    }
   
	/**
	 * Demo using WebSocket in Spring 4
	 * @param quoteType
	 * @throws Exception
	 */
	@MessageMapping("/demoPush/{quoteType}")
	public void dimond(@DestinationVariable String quoteType) throws Exception {
		Random random = new Random();
		int value = random.nextInt(10) + 1;
		int sleepTime = Integer.parseInt(value + "000");
		Thread.sleep(sleepTime);
		Quote quote = new Quote();
        quote.setAmount("$"+value+"0000");
        quote.setBranch(quoteType+" branch value");
        quote.setCoverage(quoteType+" " + sleepTime);
        quote.setName(quoteType + " Quote");
        quote.setType(value+ quoteType + value);
	    simpMessagingTemplate.convertAndSend("/topic/showResult/" + quoteType, quote);
	}
    
	/**
	 * Demo using HTML5 EventSource 
	 * @return string
	 */
    @RequestMapping(value = "/serverSentEvents", method = RequestMethod.GET, produces = "text/event-stream")
	@ResponseBody
	public String getQuoteServerSentEvents() {  
		 String data= "";
        try { 
        	Thread.sleep(1000);
    		data = "data: {\"amount\": \"$10000\", \"branch\": \"dressed in blue today\", \"type\":\"Blue Black\", \"coverage\":\"Super cop caught soup\", \"name\":\"BMW\"}\n\n";  
        } catch (InterruptedException e) {
             e.printStackTrace();
        }   
        return data;
	}
	/**
	 * Demo using classic HTTP traffic
	 * @return string
	 */
    @RequestMapping(value = "/classicHttp", method = RequestMethod.GET)
	@ResponseBody
	public String getQuoteClassicHttp() {
    	String data="";
        try { 
        	Thread.sleep(20000);
    		data = "data: {\"amount\": \"$10000\", \"branch\": \"dressed in blue today\", \"type\":\"Blue Black\", \"coverage\":\"Super cop caught soup\", \"name\":\"BMW\"}\n\n";  
        } catch (InterruptedException e) {
             e.printStackTrace();
        }   
        return data;
	}
}
