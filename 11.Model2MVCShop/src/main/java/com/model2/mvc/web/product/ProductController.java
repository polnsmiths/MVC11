package com.model2.mvc.web.product;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.http.fileupload.UploadContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@Controller
@RequestMapping("/product/*")
public class ProductController {

	///field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	///consructor
	public ProductController() {
		System.out.println(this.getClass());

	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
		
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	//경로
	private static final String UPLOAD_PATH = "C:\\workspace\\10.Model2MVCShop(Ajax)\\WebContent\\images\\uploadFiles";
	
	//@RequestMapping("/addProduct.do")
	@RequestMapping( value = "addProduct", method=RequestMethod.POST)
	public String addProduct( @ModelAttribute("product") Product product,
							@RequestParam("uploadFiles")ArrayList<MultipartFile> fileName)throws Exception{
		System.out.println("product/addProduct:POST");
		
		///////////////////////////////
		String result = "";
		int k =0;
		for(MultipartFile files : fileName) {
			k++;
			result += saveFile(files);
			if(k != fileName.size()) {
				result += ":";
			}
		}
		System.out.println("result:"+result);
		product.setFileName(result);
		System.out.println("fileNameList:"+product.getFileNameList());
		//////////////////////////////
		
		//System.out.println("_"+product.getManuDate()+"_");
		////System.out.println("_"+product.getManuDate().replace("/", "")+"_");
		String manuDate[] = product.getManuDate().split("/");
		String splitDate = "";
		for (int i = manuDate.length; i > 0 ; i--) {
			splitDate += manuDate[i-1];
			//System.out.println(splitDate);
		}
		System.out.println("_"+splitDate+"_");
		product.setManuDate(splitDate);
		productService.insertProduct(product);
		return "forward:/product/addProduct.jsp";
	}
	
	//@RequestMapping("/getProduct.do")
	@RequestMapping( value = "getProduct")
	public String getProduct( @RequestParam("prodNo") int prodNo, Model model)throws Exception{
		
		System.out.println("product/getProduct : GET");
		
		Product product = productService.findProduct(prodNo);
		//System.out.println(product);
		// Model 과 View 연결
		model.addAttribute("product", product);
		return "forward:/product/getProduct.jsp";
	}
	
	//@RequestMapping("/updateProduct.do")
	@RequestMapping( value = "updateProduct", method=RequestMethod.POST )
	public String updateProduct( @ModelAttribute("product") Product product, Model model, HttpSession session)throws Exception{
		
		System.out.println("product/updateProduct.POST");
		
		//System.out.println("prodNo:"+product.getProdNo());
		///////////////calender split////////////////
		String manuDate[] = product.getManuDate().split("/");
		String splitDate = "";
		for (int i = manuDate.length; i > 0 ; i--) {
			splitDate += manuDate[i-1];
			//System.out.println(splitDate);
		}
		//System.out.println("_"+splitDate+"_");
		product.setManuDate(splitDate);
//		System.out.println(product.getProdName());
//		System.out.println(product.getProdDetail());
//		System.out.println(product.getManuDate());
//		System.out.println(product.getPrice());
		
		//System.out.println(product);
		/////////////////////////////////////
		productService.updateProduct(product);
		
//		int sessionId = ((Product)session.getAttribute("product")).getProdNo();
//		System.out.println("//////////////////////////////");
//		System.out.println("sessionId:"+sessionId);
		
//		if(sessionId == product.getProdNo() ) {
//			session.setAttribute("product", product);
//		}
		
        return "forward:/product/getProduct?prodNo="+product.getProdNo();
	}
	
	//@RequestMapping("/updateProductView.do")
	@RequestMapping( value = "updateProductView", method=RequestMethod.GET )
	public String updateProductView( @RequestParam("prodNo") int prodNo, Model model)throws Exception{
		
		System.out.println("product/updateProductView.GET");
		
		System.out.println("prodNo:"+prodNo);
		Product product = productService.findProduct(prodNo);
		
		model.addAttribute("product", product);
		return "forward:/product/updateProductView.jsp";
	}
	
	//@RequestMapping("/listProduct.do")
	@RequestMapping( value = "listProduct")
	public String listProduct( @ModelAttribute("search") Search search,  Model model, HttpServletRequest request)throws Exception{
		
		System.out.println("product/listProduct: GET / POST");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = productService.getProductList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("resultPage:"+resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		//System.out.println("__"+request.getQueryString());
		String menu = (String)request.getParameter("menu");
		System.out.println("menu : "+menu);
		if(menu.equals("search")) {
		  	map.put("title", "상품 목록조회");
		   	map.put("page", "/product/getProduct?");
		}else {
		   	map.put("title", "상품관리");
		   	map.put("page", "/product/updateProductView?");
		}
//		request.setAttribute("title", map.get("title") );
//		request.setAttribute("page", map.get("page"));
//		request.setAttribute("menu", menu);
		model.addAttribute("title", map.get("title"));
		model.addAttribute("page", map.get("page"));
		model.addAttribute("menu", menu);
		
		return "forward:/product/listProduct.jsp";
	}
	
	private String saveFile(MultipartFile file) {
		
		UUID uuid = UUID.randomUUID();
		String saveName = uuid + "_" + file.getOriginalFilename();
		
		System.out.println("File SaveName:"+saveName);
		
		File saveFile = new File(UPLOAD_PATH, saveName);
		//File saveFile2 = new File(UPLOAD_PATH_TOMCAT, saveName);
		
			try {
				file.transferTo(saveFile);
				//file.transferTo(saveFileTomcat);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return null;
			}
		
		
		return saveName;
	}
		
		
	
	

}
