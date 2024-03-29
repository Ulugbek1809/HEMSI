﻿{*******************************************************}
{                       Talaba                          }
{                                                       }
{                   Yusupov Ulug'bek                    }
{                                                       }
{                     20.03.2024                        }
{                                                       }
{*******************************************************}

unit url;

interface

const
  universitetlar = 'https://student.buxdu.uz/rest/v1/public/university-list';
  // Universitetlar
  auth = 'auth/login'; // Authorization token
  me = 'account/me'; // Talaba malumotlari
  scheduel = 'education/schedule'; // Dars jadvali
  smestr = 'education/semesters'; // smestrlar
  fanlar = 'education/subject-list'; // Fanlar va Fan natijalari.
  talaba_davomadi = 'education/attendance'; // davomad
  nazorat_jadvali = 'education/exam-table'; // Nazorat jadvali

implementation

end.
