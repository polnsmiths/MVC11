package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;
import com.sun.org.apache.xpath.internal.operations.Mod;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {

	//field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	public PurchaseController() {
		System.out.println(this.getClass());
	}
	
	//classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것 
	//classpath:config/common.properties 를 => commonProperties로 지정해놓음
	// =>> spring EL 사용 ! @value 어노테이션으로  변수에 기본값 할당	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}") //pageUnit이 NULL이면 디폴트로 3 지정.
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
//	@RequestMapping("/addPurchaseView.do")
//	public String addPurchaseView(@RequestParam("prodNo") int prodNo, Model model)throws Exception{
	@RequestMapping(value = "addPurchaseView", method = RequestMethod.GET )
	public String addPurchaseView(@RequestParam("prodNo") int prodNo, Model model)throws Exception{
	
		System.out.println("/addPurchaseView.POST");
		
		//System.out.println("prodNo:"+prodNo);
		
		Product product = productService.findProduct(prodNo);
		//System.out.println(product);
		
		model.addAttribute("product", product);
		
		return "forward:/purchase/addPurchaseView.jsp";
	}
	
//	@RequestMapping("/addPurchase.do")
//	public String addPurchase(@ModelAttribute("purchase") Purchase purchase, Model model,
//							@RequestParam("prodNo")int prodNo, HttpSession session)throws Exception{
		
	@RequestMapping(value = "addPurchase", method = RequestMethod.POST)
	public String addPurchase(@ModelAttribute("purchase") Purchase purchase, Model model,
							@RequestParam("prodNo")int prodNo, HttpSession session)throws Exception{
		
		System.out.println("/addPurchase.GET");
		//System.out.println("prodNo:"+prodNo);
		
		Product product = productService.findProduct(prodNo);
		//System.out.println(product);
		
		User user = (User)session.getAttribute("user");
		//System.out.println(user);
		
		purchase.setBuyer(user);
		purchase.setPurchaseProd(product);
		purchase.setTranCode("1"); //구매했으니까
		System.out.println("::"+purchase.getDlvyDate());
		String dlvyDate = purchase.getDlvyDate();
		String newDate = dlvyDate.replace("-", "");
		System.out.println(newDate+"_");
		purchase.setDlvyDate(newDate);
		System.out.println(purchase);
		
		purchaseService.addPurchase(purchase);
		
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/addPurchase.jsp";
	}
	
//	@RequestMapping("/getPurchase.do")
//	public String getPurchase(@RequestParam("prodNo")int prodNo,
//							 @RequestParam("tranNo")int tranNo, Model model)throws Exception{
		
	@RequestMapping(value = "getPurchase", method = RequestMethod.GET)
	public String getPurchase(@RequestParam("prodNo")int prodNo,
							@RequestParam("tranNo")int tranNo, Model model)throws Exception{	
		System.out.println("/getPurchase.POST");
		
		System.out.println("prodNo:"+prodNo);
		System.out.println("tranNo:"+tranNo);
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		System.out.println(purchase);
		
		//System.out.println("_"+purchase.getPaymentOption()+"_");
		if((purchase.getPaymentOption()).trim().equals("1")) {
			purchase.setPaymentOption("현금 구매");
		}else {
			purchase.setPaymentOption("카드구매");
		}
		
		model.addAttribute("purchase", purchase);
		model.addAttribute("prodNo", prodNo);
		
		return "forward:/purchase/getPurchase.jsp";
	}
	
//	@RequestMapping("/listPurchase.do")
//	public String listPurchase(@ModelAttribute("search")Search search, 
//							HttpSession session, Model model)throws Exception{
		
	@RequestMapping(value = "listPurchase")
	public String listPurchase(@ModelAttribute("search")Search search, 
						HttpSession session, Model model)throws Exception{
		System.out.println("/listPurchase");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		String buyerId = ( (User)session.getAttribute("user") ).getUserId();
		//System.out.println(":"+buyerId);
		Map<String, Object>map = purchaseService.getPurchaseList(search, buyerId);
		//System.out.println(map.get("list"));
		//System.out.println(map.get("totalRow"));
		//System.out.println("물건도착 확인:"+map.get("arrived"));
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalRow")).intValue() , pageUnit, pageSize) ;
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("arrived", map.get("arrived"));
		model.addAttribute("state", map.get("state"));
		System.out.println(":::"+map.get("list"));
		
		return "forward:/purchase/listPurchase.jsp";

	}
	
//	@RequestMapping("/updateTranCode.do")
//	public String updateTranCode(@RequestParam("currentPage")int currentPage,
//								@RequestParam("tranNo")int tranNo, 
//								@RequestParam("tranCode")String tranCode, Model model)throws Exception{
	
	@RequestMapping(value = "updateTranCode", method = RequestMethod.GET)
	public String updateTranCode(@RequestParam("currentPage")int currentPage,
			@RequestParam("tranNo")int tranNo, 
			@RequestParam("tranCode")String tranCode, Model model)throws Exception{
		System.out.println(":"+currentPage);
		System.out.println(":"+tranNo);
		System.out.println(":"+tranCode);
		
		purchaseService.updateTranCode(tranNo, tranCode);
		Search search = new Search();
		search.setCurrentPage(currentPage);
		
		model.addAttribute("search", search);
		return "forward:/purchase/listPurchase";
	}
	
//	@RequestMapping("/updatePurchaseView.do")
//	public String updatePurchaseView(@RequestParam("tranNo")int tranNo,
//									@RequestParam("prodNo")int prodNo, Model model)throws Exception{
		
	@RequestMapping(value = "updatePurchaseView", method = RequestMethod.GET)
	public String updatePurchaseView(@RequestParam("tranNo")int tranNo,
									@RequestParam("prodNo")int prodNo, Model model)throws Exception{
			
		System.out.println("/updatePurchaseView.POST");
		//System.out.println("prodNo:"+prodNo);
		//System.out.println("tranNo:"+tranNo);
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		System.out.println(purchase);
		
		model.addAttribute("purchase", purchase);
		model.addAttribute("prodNo", prodNo);
		
		return "forward:/purchase/updatePurchaseView.jsp";
	}
	
//	@RequestMapping("/updatePurchase.do")
//	public String updatePurchase(@RequestParam("tranNo")int tranNo, Model model,
//						@RequestParam("prodNo")int prodNo, @ModelAttribute("purchase")Purchase purchase)throws Exception{
		
	@RequestMapping(value = "updatePurchase", method = RequestMethod.GET)
	public String updatePurchase(@RequestParam("tranNo")int tranNo, Model model,
								@RequestParam("prodNo")int prodNo, 
								@ModelAttribute("purchase")Purchase purchase)throws Exception{	
		System.out.println("/updatePurchase.POST");
		//System.out.println("tranNo:"+tranNo);
		//System.out.println("prodNo:"+prodNo);
		//System.out.println(purchase);
		
		purchaseService.updatePurchase(purchase);

		model.addAttribute("tranNo", tranNo);
		model.addAttribute("prodNo", prodNo);
		return "forward:/purchase/getPurchase";
	}
	
//	@RequestMapping("/listSale.do")
//	public String listSale(@ModelAttribute("search")Search search, Model model)throws Exception{

	@RequestMapping(value = "listSale")
	public String listSale(@ModelAttribute("search")Search search, Model model)throws Exception{
		System.out.println("/listSale");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = purchaseService.getSaleList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount") ).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		model.addAttribute("purchase", map.get("saleList"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("delivery", map.get("delivery"));
		model.addAttribute("state", map.get("state"));
		return "forward:/purchase/listSale.jsp";
		
	}
	
//	@RequestMapping("/updateTranCodeByAdmin.do")
//	public String updateTranCodeByAdmin(@RequestParam("currentPage")int currentPage,
//								@RequestParam("tranNo")int tranNo, 
//								@RequestParam("tranCode")String tranCode, Model model)throws Exception{
	@RequestMapping(value = "updateTranCodeByAdmin", method = RequestMethod.GET)
	public String updateTranCodeByAdmin(@RequestParam("currentPage")int currentPage,
								@RequestParam("tranNo")int tranNo, 
								@RequestParam("tranCode")String tranCode, Model model)throws Exception{	
		System.out.println(":"+currentPage);
		System.out.println(":"+tranNo);
		System.out.println(":"+tranCode);
		
		purchaseService.updateTranCode(tranNo, tranCode);
		Search search = new Search();
		search.setCurrentPage(currentPage);
		
		model.addAttribute("search", search);
		return "forward:/purchase/listSale";
	}
	
	
	
	
	
	
	
	
}
