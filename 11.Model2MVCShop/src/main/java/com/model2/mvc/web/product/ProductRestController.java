package com.model2.mvc.web.product;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@RestController
@RequestMapping("/product/*")
public class ProductRestController {

    //field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	//list에 사용할 spEL사용해서 properties파일 읽어오기
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
	//생성자
	public ProductRestController() {
		System.out.println(this.getClass());
	}
	
//	@RequestMapping(value = "json/getProduct/{prodNo}", method = RequestMethod.GET)
//	public Product getProduct( @PathVariable int prodNo)throws Exception{
//		System.out.println("/product/json/getProduct : GET");
//		
//		//business Logic
//		return productService.findProduct(prodNo);
//	}
	
	@RequestMapping(value = "json/getProduct", method = RequestMethod.POST)
	public Product getProduct( @RequestBody int prodNo)throws Exception{
		
		System.out.println("/product/getProduct : POST");
		System.out.println("prodNo:"+prodNo);
		
		Product product = productService.findProduct(prodNo);
		
		return product;
	}
	
	@RequestMapping( value = "json/addProduct", method = RequestMethod.POST )
	public Product addProduct(@RequestBody Product product)throws Exception{
		
		System.out.println("/product/addProduct : POST");
		
		System.out.println("::"+product);
		productService.insertProduct(product);
		//addProduct는  void
		
//		System.out.println(product.getProdNo()); //Mapper에서 set해주고 request할때는 set안 해줘서 NULL
//		Product returnProduct = productService.findProduct(product.getProdNo());
		
		//return returnProduct;
		return product;
	}

	/////////////////////////////////////////////////////////////
	@RequestMapping(value = "json/listProduct", method = RequestMethod.POST)
	public Map listProduct(@RequestBody Search search) throws Exception{
		
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		Map<String, Object> map = productService.getProductList(search);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
		

		map.put("list", map.get("list"));
		//map.put("title", map.get("title"));
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		return map;
	}
}
