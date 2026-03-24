Create database Students

create collection students



show dbs



##### **Insert values to the students**

**Query:** use test db.students.insertMany(\[{name:"Bhabuk", age:18, grade:"A"},{name:"Hari", age:19, grade:"B"},{name:"Sita", age:20,grade:"A"} ])



##### **To see records of all students**

&#x20;**Query:** db.students.find().pretty()

&#x20;**Output:** \[

&#x20; {

&#x20;   \_id: ObjectId('69c1f1c7aed05c0ccc11402a'),

&#x20;   name: 'Bhabuk',

&#x20;   age: 18,

&#x20;   grade: 'A'

&#x20; },

&#x20; {

&#x20;   \_id: ObjectId('69c1f1c7aed05c0ccc11402b'),

&#x20;   name: 'Hari',

&#x20;   age: 19,

&#x20;   grade: 'B'

&#x20; },

&#x20; {

&#x20;   \_id: ObjectId('69c1f1c7aed05c0ccc11402c'),

&#x20;   name: 'Sita',

&#x20;   age: 20,

&#x20;   grade: 'A'

&#x20; }

]





##### 

##### **Students age greater than 18**

&#x20;**Query:** db.students.find({age:{$gt:18}}).pretty()

**Output:** \[

&#x20; {

&#x20;   \_id: ObjectId('69c1f1c7aed05c0ccc11402b'),

&#x20;   name: 'Hari',

&#x20;   age: 19,

&#x20;   grade: 'B'

&#x20; },

&#x20; {

&#x20;   \_id: ObjectId('69c1f1c7aed05c0ccc11402c'),

&#x20;   name: 'Sita',

&#x20;   age: 20,

&#x20;   grade: 'A'

&#x20; }

]



##### **to print students whose grade is A**

**Query:** db.students.find({grade:"A"}).pretty()

**Output:**\[

&#x20; {

&#x20;   \_id: ObjectId('69c1f1c7aed05c0ccc11402a'),

&#x20;   name: 'Bhabuk',

&#x20;   age: 18,

&#x20;   grade: 'A'

&#x20; },

&#x20; {

&#x20;   \_id: ObjectId('69c1f1c7aed05c0ccc11402c'),

&#x20;   name: 'Sita',

&#x20;   age: 20,

&#x20;   grade: 'A'

&#x20; }

]



##### **To find student named Bhabuk**

**Query:** db.students.find({name:"Bhabuk"}).pretty()

**Output:**\[

&#x20; {

&#x20;   \_id: ObjectId('69c1f1c7aed05c0ccc11402a'),

&#x20;   name: 'Bhabuk',

&#x20;   age: 18,

&#x20;   grade: 'A'

&#x20; }

]



##### **To update grade of Student named Hari to C**

**Query:** db.students.updateOne({name:"Hari"},{$set:{grade:"C"}})

**Output:** {

&#x20; acknowledged: true,

&#x20; insertedId: null,

&#x20; matchedCount: 1,

&#x20; modifiedCount: 1,

&#x20; upsertedCount: 0

}



##### **To update grade of many students whose age is lower than 20 to C**

**Query:** db.students.updateMany({age:{$lt:20}},{$set:{grade:"C"}})

**Output:** {

&#x20; acknowledged: true,

&#x20; insertedId: null,

&#x20; matchedCount: 2,

&#x20; modifiedCount: 1,

&#x20; upsertedCount: 0

}



##### **To delete record of student named Sita**

**Query:**db.students.deleteOne({name:"Sita"})

**Output:**{ acknowledged: true, deletedCount: 1 }





##### **To count total Students**

**Query:** db.students.countDocuments()

**Output:** 2



##### **To count the students whose grade is C**

**Query:** db.students.countDocuments({grade:"C"})

**Output:**2



##### **To sort in ascending order based on name**

**Query:** db.students.find().sort({age:1}).pretty()

**Output:** \[

&#x20; {

&#x20;   \_id: ObjectId('69c1f1c7aed05c0ccc11402a'),

&#x20;   name: 'Bhabuk',

&#x20;   age: 18,

&#x20;   grade: 'C'

&#x20; },

&#x20; {

&#x20;   \_id: ObjectId('69c1f1c7aed05c0ccc11402b'),

&#x20;   name: 'Hari',

&#x20;   age: 19,

&#x20;   grade: 'C'

&#x20; }

]



#### **To add new field**

**Query:** db.students.updateMany({},{$set:{city:"Kathmandu"}})

**Output:** {

&#x20; acknowledged: true,

&#x20; insertedId: null,

&#x20; matchedCount: 2,

&#x20; modifiedCount: 2,

&#x20; upsertedCount: 0

}



##### **To delete the records of students of age between 18 to 21**

**Query:** db.students.updateMany({},{$set:{city:"Kathmandu"}})

**Output:** {

&#x20; acknowledged: true,

&#x20; insertedId: null,

&#x20; matchedCount: 2,

&#x20; modifiedCount: 2,

&#x20; upsertedCount: 0

}

