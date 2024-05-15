import { LightningElement,track,api } from 'lwc';
import {
    EXAMPLES_COLUMNS_DEFINITION_BASIC,
    EXAMPLES_DATA_BASIC,
} from './sampleData';

export default class TreeInterface extends LightningElement {

    @track currentExpandedRows;

    // definition of columns for the tree grid
    gridColumns =  [
        {
            type: 'text',
            fieldName: 'accountName',
            label: 'Account Name',
            iconName:'standard:contact',
            type:'', label:'icon' ,typeAttributes: {
                
                name: 'Delete',
                title: 'Delete',
                disabled: false,
                value: 'delete',
                iconPosition: 'left',
                iconName:'doctype:folder',
                variant:'base',
                
            }
        }
    ];

    // data provided to the tree grid
    gridData = [
        {
        name: '125313-7j',
        accountName: 'Dach-Welch',
        phone: '837-555-0100',
        iconName:'standard:contact'
    },
    {
        name: '584996-s7',
        accountName: 'Corkery-Windler',
        phone: '837-555-0100',
        _children: [
            {
                name: '747773-jw',
                accountName: 'Corkery-Abshire',
                phone: '837-555-0100',
            },
            {
                name: '377526-zg',
                accountName: 'Robel, Friesen and Flatley',
                phone: '837-555-0100',
                _children: [
                    {
                        name: '955330-wp',
                        accountName: 'Donnelly Group',
                        phone: '837-555-0100',
                    },
                    {
                        name: '343693-9x',
                        accountName: 'Kshlerin Group',
                        phone: '837-555-0100',
                    },
                ],
            },
            {
                name: '638483-y2',
                accountName: 'Bruen, Steuber and Spencer',
                phone: '837-555-0100',
            },
        ],
    },
    {
        name: '306979-mx',
        accountName: 'Spinka LLC',
        phone: '837-555-0100',
    },
    {
        name: '066195-o1',
        accountName: 'Koelpin LLC',
        phone: '837-555-0100',
    }
];

    // list of names for rows that are expanded
    // gridExpandedRows = [
    //     '123556',
    //     '123556-A',
    //     '123556-B',
    //     '123556-B-B',
    //     '123557',
    // ];

    // retrieve the list of rows currently marked as expanded
    getCurrentExpandedRows() {
        const treegrid = this.template.querySelector('.lgc-example-treegrid');
        this.currentExpandedRows = treegrid.getCurrentExpandedRows().toString();
    }

}