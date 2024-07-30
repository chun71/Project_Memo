
package testItem;

import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;
import java.util.Scanner;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;

public class Test2023 {
	 private Test2023(){
			
	}
		
	public static final Test2023 Obj = new Test2023();
	    
		/**
		 * 特殊字元存檔問題測試
		 * @throws Exception
		 */
		public void test0502() throws Exception {
			String path = "C:\\Users\\kevin.lee\\Downloads\\",  fileName = "";
			ArrayList<String> testStrList = new ArrayList<String>();
			testStrList.add("-");
			testStrList.add("#");
			testStrList.add("@");
			testStrList.add("~");
			testStrList.add("&");
//			testStrList.add("<");
//			testStrList.add(">");
//			testStrList.add("*");
//			testStrList.add("/");
			testStrList.add("%");
			
	 		for(int i = 0; i < testStrList.size(); i++) {
	 			fileName = String.format("%03d", i) + testStrList.get(i) + "file.txt";
	            String message = String.format("test%03d", i);
	            
	            saveData(path + fileName, message);
	            System.out.println("Now " + fileName + " is created");
			}
		}

		/**Data Logger資料夾路徑*/
		private String DataLoggerPath = "C:\\DTM319A\\";
		/**Data Logger讀取資料執行檔*/
		private String taskNane = "dtm319a.exe";
		/**Data Logger資料記錄檔*/
		private String dataFileName = "data.dtm";
		/**Data Logger讀值執行或結束旗標*/
		private String actionFlagFileName = "actionFlag.dtm";
		
		/**
		 * Data Logger DTM-319A 測試
		 * @throws InterruptedException 
		 * @throws Exception 
		 */
		public void test0728() throws Exception {
			saveData(DataLoggerPath + dataFileName, "");
			saveData(DataLoggerPath + actionFlagFileName, "");
			
			try {
	            Process process = Runtime.getRuntime ().exec(DataLoggerPath + taskNane);
	            Thread.sleep(5000);
	            if (process.isAlive()) {
	            	String data = "";
	            	int failTimes = 0;
	    			
	    			do {
	    				if (failTimes == 10){
	    					saveData(DataLoggerPath + actionFlagFileName, "finish");
	    					System.out.println("請確認\n1.Data Logger通訊是否正常\n2.Data Logger是否為開機狀態");
	    					break;
	    				}
	    				
	    				data = readData(DataLoggerPath + dataFileName);
	    				
	    				if (!(data.isEmpty() || data == null)) {
	    					String [] datas = data.split(",");
	    					double [] dataList = new double[datas.length];
	    					
	    					for (int i = 0; i < datas.length; i++) {
	    						dataList[i] = Double.parseDouble(datas[i]);
	    						System.out.println("T" + (i + 1) + "溫度為 " + dataList[i] + "°C");
	    					}
	    					
	    					saveData(DataLoggerPath + actionFlagFileName, "finish");
	    					break;
	    				}
	    				
	    				failTimes++;
	    				Thread.sleep(1000);
	    			}while(true);
	            }else{
	            	saveData(DataLoggerPath + actionFlagFileName, "finish"); 
	            	System.out.println("請確認\n1.Data Logger通訊是否正常\n2.Data Logger是否為開機狀態");
	            }
	        } catch (Exception e) {
	            e.printStackTrace ();
	        }
		}
		
		/**
		 * 路徑檔案最後修改時間與現在時間比較
		 */
		public void test080901() {
			String path = "C:\\DTM319A\\data.dtm";	
			Date lastModifiedTime = new Date( new File(path).lastModified());
			long elapsedms = Math.abs(lastModifiedTime.getTime() - new Date().getTime()) / 1000;
			System.out.println(elapsedms + "s");		 
		}
	
		/**
		 * 開啟cmd視窗執行應用程式
		 * @throws Exception
		 */
		public void test080902() throws Exception {
			 Runtime.getRuntime ().exec("cmd.exe /C start " + DataLoggerPath + taskNane);
		}
		
		/**
		 * Properties讀取測試
		 * @throws IOException
		 */
		public void test0919() throws IOException {
			String path = "src\\appsetting.txt";
			InputStream inputStrem = new BufferedInputStream (new FileInputStream(path));
			Properties propertis =  new Properties();
			propertis.load(inputStrem);
//			propertis.list(System.out);
			System.out.println(propertis.getProperty("AC_Source.portNumber"));
		}		
		
		/**
		 * 讀取檔案
		 * @param path
		 * @throws InterruptedException 
		 */
		private String readData(String path) throws InterruptedException {
			BufferedReader reader = null;
			String msg = "";
			
			do {
				if (new File(path).isFile()) {
					try {
						  reader = new BufferedReader(new InputStreamReader(new FileInputStream(path), "UTF-8"));
						  String str = null;
						  while ((str = reader.readLine()) != null) {
							  msg = msg + str;
						  }
						} catch (FileNotFoundException e) {
						  e.printStackTrace();
						} catch (IOException e) {
						  e.printStackTrace();
						} finally {
						  try {
						    reader.close();
						  } catch (IOException e) {
						    e.printStackTrace();
						  }
					    }
					break;
				}
			}while(true);
			
			return msg;
		}
		
		/**
		 * 存取檔案
		 * @param path
		 * @param msg
		 */
		private void saveData(String path, String msg) {
			try {
				FileOutputStream fos = new FileOutputStream(path);
	            BufferedOutputStream bos = new BufferedOutputStream(fos);
	            byte[] bytes = msg.getBytes();
	            bos.write(bytes);
	            bos.close();
	            fos.close();
			} catch (FileNotFoundException ex) {
				System.out.println(ex.getMessage());
			} catch (IOException e) {
				System.out.println(e.getMessage());
			}	
		}
}
