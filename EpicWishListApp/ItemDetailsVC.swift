//
//  ItemDetailsVC.swift
//  EpicWishListApp
//
//  Created by Shayan Zahid on 08/07/2017.
//  Copyright © 2017 Shayan Zahid. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var detailsField: UITextField!
    @IBOutlet weak var thumbImage: UIImageView!
    
    var stores = [Store]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    var originalItemTitle: String!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        if let topItem = self.navigationController?.navigationBar.topItem
        {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        storePicker.dataSource = self
        storePicker.delegate = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
       
        fetchStore()
        
        if itemToEdit != nil
        {
            loadExistingItem()
        }
    }

    @IBAction func saveBtnPressed(_ sender: UIButton)
    {
        var item: Item!
        let picture = Image(context: context)
        picture.image = thumbImage.image
        
        if itemToEdit == nil
        {
            item = Item(context: context)
        } else
        {
            item = itemToEdit
        }
        
        item.toImage = picture
        
        if let title = titleField.text
        {
            item.title = title.capitalized
        }
        
        if let price = priceField.text
        {
            item.price = (price as NSString).doubleValue
        }
        
        if let details = detailsField.text
        {
            item.details = details
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        appDelegate.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteBtnPressed(_ sender: UIBarButtonItem)
    {
        if itemToEdit != nil
        {
            context.delete(itemToEdit!)
            appDelegate.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func imageSelectBtnPressed(_ sender: UIButton)
    {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return stores[row].name
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return stores.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
    }
    
    func fetchStore()
    {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do
        {
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        } catch
        {
            let error = error as NSError
            print(error.debugDescription)
        }
    }
    
    func loadExistingItem()
    {
        if let item = itemToEdit
        {
            titleField.text = item.title
            priceField.text = String(item.price)
            detailsField.text = item.details
            thumbImage.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore
            {
                for index in 0..<stores.count
                {
                    let s = stores[index]
                    if s.name == store.name
                    {
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                }
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            thumbImage.image = image
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
