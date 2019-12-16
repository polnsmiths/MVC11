package com.model2.mvc.service.purchase;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;

@Service
public interface PurchaseService {
	
	public Map<String, Object>getPurchaseList(Search search, String buyerId)throws Exception;
	
	public Purchase getPurchase(int tranNo)throws Exception;
	
	public void updatePurchase(Purchase purchase)throws Exception;
	
	public Map<String, Object>getSaleList(Search search)throws Exception;
	
	public void addPurchase(Purchase purchase)throws Exception;
	
	public void updateTranCode(int tranNo, String tranCode)throws Exception;
}
