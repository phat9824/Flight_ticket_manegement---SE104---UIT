﻿using DAL;
using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class Ticket_Class_BLL
    {
        public List<TicketClassDTO> L_TicketClass()
        {
            /*Ticket_classAccess ticket_class = new Ticket_classAccess();
            return ticket_class.L_TicketClass();*/
            return new DAL.Ticket_classAccess().L_TicketClass();
        }
        public string InsertTicketClass(TicketClassDTO ticketClass)
        {
            return new DAL.Ticket_classAccess().Add_TicketClass(ticketClass);
        }
        public int DeleteTicketClass(string ID)
        {
            return new DAL.Ticket_classAccess().DeleteTicketClass(ID);
        }
        public string GetState()
        {
            return new DAL.Ticket_classAccess().GetState();
        }
    }
}
