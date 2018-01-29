package com.mmm.ekwento

import grails.transaction.Transactional

import java.io.File;
import java.io.FileInputStream;
import java.util.List;

import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.extractor.WordExtractor;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;

@Transactional
class WordExtractorService {

    def readDocFile = { docFile ->
		String content = "";
		try {
			FileInputStream fis = docFile.getInputStream()

			HWPFDocument doc = new HWPFDocument(fis);

			WordExtractor we = new WordExtractor(doc);

			String[] paragraphs = we.getParagraphText();
			
			
			println("Total no of paragraph "+paragraphs.length);
			for (String para : paragraphs) {
				//println(para.toString());
				content += para.toString()
			}
			fis.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return content
	}
	
	def readDocxFile = { docx ->
		String content = "";
		try {
			FileInputStream fis = docx.getInputStream()

			XWPFDocument document = new XWPFDocument(fis);

			List<XWPFParagraph> paragraphs = document.getParagraphs();
			
			
			println("Total no of paragraph "+paragraphs.size());
			for (XWPFParagraph para : paragraphs) {
				//println();
				content += para.getText()
			}
			fis.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return content;
	}
}
